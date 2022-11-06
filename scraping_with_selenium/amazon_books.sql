
-- causion!! 
---- following codes are written in form of postgresql.
--- some sql function below might not work in SQL and MYSQL.





------- update book_weight column

--- this query will get unique measurement of the book weight
select distinct( substring(book_weight,  position(' ' in book_weight)+1,position(' ' in book_weight)+3 ) ) as weight_measurement
from amazon_books_ver1

--- the previous query shows there is nan, g, and kg . the unit of measurement is not unified. 
-- so will set all measuremeant of weight as gram.
----- the code do job
ALTER TABLE amazon_books_ver1
ADD book_weight_gram numeric

UPDATE amazon_books_ver1
SET book_weight_gram = 
	CASE 
		WHEN book_weight LIKE '%.%' AND  book_weight LIKE '%kg%' THEN  	ROUND( CAST( TRIM( REPLACE(  REPLACE( book_weight, 'kg','' ), 'g',''  )  ) AS numeric ) * 1000 ,0 ) 
		ELSE CAST( TRIM( REPLACE(  REPLACE( book_weight, 'kg','' ), 'g',''  )  ) AS numeric )
	END
----- end 

---- update book_price 

select distinct( substring( price, 1,1)   )  
from amazon_books_ver1

---  price column contains 2 sympobls of price: CAD$ and $.
--- so remove  both of them and just keep numeric numbers.

----- the code do the job 
ALTER TABLE amazon_books_ver1
ADD price_$ numeric 

with book_price as (
	select 	book_id,
	CASE 
	WHEN price like '%$%'and not price like '%CDN%' THEN CAST( TRIM( REPLACE( REPLACE(price,'$',''),',','' ) ) AS NUMERIC) 
	else CAST (  TRIM( REPLACE( REPLACE(price,'CDN$',''),',','' ) )AS NUMERIC) 
	end as price
FROM amazon_books_ver1
)
UPDATE amazon_books_ver1
SET price_$ = book_price.price
from book_price 
where book_price.book_id = amazon_books_ver1.book_id
----- end 


----=--- update review number

--- the review_number column contains string 'unknown' other than numbers 
--- so replace the string to NaN and change the datatype to numeric.

------ the code do job 
alter table amazon_books_ver1
add review_num numeric

UPDATE amazon_books_ver1
SET review_num  = 
	CASE WHEN number_of_review  ='unknown' THEN CAST (replace(number_of_review ,'unknown',NULL)AS NUMERIC) 
	WHEN number_of_review  ='NaN' THEN CAST (replace(number_of_review ,'NaN',NULL)AS NUMERIC) 
	else  CAST( number_of_review AS INTEGER)
	end
------end 


------ update audible_length

--- this query shows the datatype of column is varcher and shows length with hour and minutes + only hour  + only minutes
---- also the format of  audible_length is not united.. such as some of datapoints have only have hour or minutes.
select audible_length 
from amazon_books_ver1
where not audible_length = 'nan'
-------- so need to change the datatype to date and let the code parse the date from string based on the way to express date in string.

--- the code do job
alter table amazon_books_ver1
add audible_length_minute integer

with audible_length_minutes as (
	select book_id,
	case when audible_length like '%hours%and%minutes' 
		then  trim (replace( replace( audible_length,'minutes',''), 'hours and',' ,')) 
	when audible_length like '%hours%and%minute' 
		then trim (replace( replace( audible_length,'minute',''), 'hours and',' ,') )
	when audible_length like '%hours' 
		then  replace (audible_length ,'hours',' ,60') 
	when audible_length like '%hour%and%minutes' 
		then trim (replace( replace( audible_length,'minutes',''), 'hour and',' ,') )
	when audible_length like '%minutes' then trim('minutes' from audible_length)
	else '0'
	end as length_ver1
from amazon_books_ver1
)
update amazon_books_ver1
set audible_length_minute = 
	case 
	when  length_ver1  like '%60' then  cast ( substring(length_ver1,1,position('' in length_ver1)+1)   as integer)*60
	when length_ver1  like '% ,%' 
		then cast ( substring(length_ver1,1,position('' in length_ver1)+1) as integer)*60 + 
			cast( trim( replace ( substring(length_ver1, position('' in length_ver1)+4,10 ) ,',','')) as integer)
		
		-- *60 + cast ( substring(audible_length_minutes, position('' in audible_length_minutes)+2,10 )as numeric )
	else   cast (length_ver1 as integer)
	end
from audible_length_minutes
where amazon_books_ver1.book_id = audible_length_minutes.book_id
--- end 

---- update file_size column

---- datapoints in the column contains string 'KB' so remove the string to make futher data analysis easier.
select distinct file_size from amazon_books_ver1

--- the code do job
alter table amazon_books_ver1
add file_size_kb integer 

update amazon_books_ver1
set file_size_kb = 	
	case when file_size like'%KB' then cast( trim(replace (file_size, 'KB','')) as integer)
	else 0
	end
--- end 




---- update page_number column
select distinct page_number from amazon_books_ver1
--- data points in the page_number column contains string "pages" so remove it for further data analysis 


-- the code do job 
alter table amazon_books_ver1
add page_num integer 

update amazon_books_ver1
set page_num = 	
	case when page_number like'%pages' then  cast ( trim(replace (page_number, 'pages','')) as integer)
	else 0
	end
-- end 


--- update the publisher column.
--- some value contains ';' but others do not. remove the ';' to avoid consdiering same publisher with ';' and without ';' as different publihser 

-- the code do job
update amazon_books_ver1
set publisher = 
	case when  publisher like '%;%' then trim( replace(  replace (substring(publisher,1,position(';'in publisher)),';',''),'''','') )  
	else publisher
	end
--- end 



--------------  split the book_dimention variable into  3 new variables> ( height, width, thickness)

--- the code do job

alter table amazon_books_ver1
add book_width numeric,
add book_thick numeric,
add book_height numeric
select * from amazon_books_ver1

with dimention as (
	select book_key,
		cast (trim (cast ( f as json) ->> 0) as numeric) as width, 
	 	cast (trim(cast ( f as json)->> 1)as numeric) as thick,
	 	cast (trim(cast ( f as json) ->> 2)as numeric) as height
from amazon_books_ver1
left join lateral concat('["',replace(trim('cm' from book_dimensions),' x','","'),'"]') f on true
order by book_key
), corrected_width as (
select book_key,
	case when width < thick and width < height and width > 6 then thick
	when height < thick and height < width and height > 6 then thick
	when  width < thick and width < height and width < 6  then NULL
	when  height < thick and height < width and height < 6 then  NULL
	else width
	end as new_width
from dimention
order by book_key
),corrected_thick as (
select book_key,
	case when width < thick and width <  height    then width
	when height < thick and height < width  then height
	when height is NULL then NULL
	when thick > 10 then NULL
	else thick 
	end as new_thick
from dimention
order by book_key
),
corrected_height as (
	select book_key,
	case when height < thick and height <  width    then width 
	-- when height is NULL then NULL
	else height
	end as new_height
from dimention
order by book_key
), new_dimention as (select a.book_key,a.new_width,b.new_thick, c.new_height from corrected_width as a 
join corrected_thick as b  
on  a.book_key = b.book_key
join corrected_height as c 
on  a.book_key = c.book_key
)
-- run the code with 'with query'
update amazon_books_ver1
set book_width = new_width,
	book_height = new_height,
	book_thick = new_thick
from new_dimention
where amazon_books_ver1.book_key = new_dimention.book_key
--- end 

----- update release_date column

--- most datapoint has release_date in certain format but there are some exceptions 'nan','Wicca Shorts','AFNIL - France','first , 1st'


----- the codes do job
alter table amazon_books_ver1
add date_release date 


update amazon_books_ver1
set date_release = 
	case when length(release_date ) < 15 and length(release_date ) > 10  and not trim(release_date) like '%n' then cast (replace(release_date,'.','') as date)
	else cast (null as date)
	end
	where not release_date in ('nan','Wicca Shorts','AFNIL - France','first , 1st')

select release_date,date_release from  amazon_books_ver1
---- end 



----- create 5 different columns from book_rates..


---  the codes do job
alter table amazon_books_ver1
add rate_5 int,
add rate_4 int,
add rate_3 int,
add rate_2 int,
add rate_1 int

with book_rates as (
	 select book_id,
	  cast ( trim ( cast (f as json) ->> 0 )as int )  as  rate_5,
	  cast ( trim ( cast (f as json) ->> 1 )as int )  as  rate_4,
	  cast ( trim ( cast (f as json) ->> 2 )as int )  as rate_3,
	  cast ( trim ( cast (f as json) ->> 3 )as int ) as  rate_2,
	  cast ( trim ( cast (f as json) ->> 4 )as int ) as  rate_1
from amazon_books_ver1
LEFT JOIN LATERAL concat('["' ,replace(trim('[%]' from dist_rating),'%,','", "'), '"]') f  on true
	) 
update amazon_books_ver1
set rate_5 = book_rates.rate_5,
rate_4 = book_rates.rate_4,
rate_3 = book_rates.rate_3,
rate_2 = book_rates.rate_2,
rate_1 = book_rates.rate_1
from book_rates
where book_rates.book_id = amazon_books_ver1.book_id


----  add new variable. weighted value of total review * rating  out of 1(1 is max 0 is min) / 100
--- this variable add more value on more reviewed book and less weight on low average review rate.
--- also scaled by 0.01. 

--- the codes do job 
alter table amazon_books_ver1
add review_score numeric

update amazon_books_ver1
set review_score = 
 	case when  review_num >100 and  rating > 0  then round(cast((review_num*rating /100)  as numeric), 2 )
	else NUll
	end
-- end 

---- add new variable 'estimated annual sales'

--- assumption: 5% of purshaced population post review rate
--- then revinew number * 20 =  estimated number of sales 
---  revinew number * 20 * book_price = estimated total sales.



-- the codes do work

alter table amazon_books_ver1
--drop estimated_annual_sales
add estimated_total_sales numeric 

with estimated as (
select 
	case when round(EXTRACT(day from now()- date_release )/365,2) > 0 then round((review_num*20*price_$),2)
	else NULL
	end as estimated_total_sales
from amazon_books_ver1
where not price = 'NaN' and not review_num is NULL 
) 
update amazon_books_ver1
set estimated_total_sales = 
	case when round(EXTRACT(day from now()- date_release )/365,2) > 0 and not price = 'NaN' and not review_num is NULL 
	then round( (review_num*20*price_$) / (EXTRACT(day from now()- date_release )/365),2)
	when round(EXTRACT(day from now()- date_release )/365,2) = 0 and not price = 'NaN' and not review_num is NULL 
	then NULL
	else NULL
	end
----  just in case if the update contain 'NaN'
update amazon_books_ver1
set estimated_total_sales = 
	case when estimated_total_sales = 'NaN' then NULL
	else estimated_total_sales
	end
--- end 

---- add new categorical variables based on ranking.
--- top rank : rank1-25
--- middle rank : rank26-75
--- low rank: rank 76-100

-- the code do job
alter table amazon_books_ver1
add rank_text  varchar(20)

with num_rank as (
select book_key, cast ( trim(replace(rank,'#','')) as numeric)  as ranks
from amazon_books_ver1
)
update amazon_books_ver1
set rank_text = 
	case when ranks between 1 and 25 then 'Top rank'
	when ranks between 26 and 75 then 'Middle rank'
	else 'Low rank'
	end 
from num_rank
where amazon_books_ver1.book_key = num_rank.book_key
-- end 



------ the data clearning wrangling part are done 
----- split the table into Audible table , Kindle table and other_types table 


--- audible 
copy(
with audible as (
select * ,row_number() over(
	partition by book_id
	order by book_key
	)
from amazon_books_ver1
where book_type = 'AudibleAudiobook'
)
----- run following delte command first before "select everything from audible"
-- delete
--from amazon_books_ver1
--where amazon_books_ver1.book_key in (select book_key from audible where row_number > 1)
select * from audible
)
TO '/tmp/audible_table.csv' DELIMITER ',' CSV HEADER;

--end 

---- kindle 

copy(
with kindle as (
select * ,row_number() over(
	partition by book_id
	order by book_key
	)
from amazon_books_ver1
where book_type = 'KindleEdition' 
)

----- run following delte command first before "select everything from kindle"
--delete
--from amazon_books_ver1
--where amazon_books_ver1.book_key in (select kindle.book_key from kindle where row_number > 1)
select * from kindle
)
TO '/tmp/kindle_table.csv' DELIMITER ',' CSV HEADER;

--end 

---- other types 

---- removing duplicated book with lower ranking.
---   using parition with oder by book_key allow this , becasue book_key correspond with ranking.
--- example:  if there are so same book that are rank1 and rank20 ,then rank20 one will be removed from query.

-- the codes do job
copy(
with books as (
select * ,row_number() over(
	partition by  book_id
	order by book_key
	)
from amazon_books_ver1
where not book_type in( 'AudibleAudiobook'  ,'KindleEdition' )
)
	
----- run following delte command first before "select everything from books"
--delete 
--from amazon_books_ver1
--where book_key in (select book_key from books where row_number > 1)
	
select * from books
) TO '/tmp/books_table.csv' DELIMITER ',' CSV HEADER;














