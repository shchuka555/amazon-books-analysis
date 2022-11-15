# Amazon books analysis

## Table of Contents

- [Overview](#Overview)  
- [Motivation](#Motivation)
- [File_Introduction](#File_Introduction)  
- [Technology](#Technology)  
- [Procedure](#Procedure)  
- [Data_Visualization_Analysis](#Data_Visualization_Analysis)
- [Conclusion](#Conclusion)  

## Overview
In this project
- Collected data from Amazon using Python
- Cleaned and transformed the data gathered into a more useable form by SQL
- Used Tableau-public to visualize data.

## Motivation
- Exploring and polishing my scraping and SQL skills.
  - Applying the analysis to real-world data.
  - Challenging to collect data from popular website.
- To analyze book data and recommend what amazon.ca should care and not about books on the market.


## Technology 
I used the following programming languages and libraries.
- SQL (PostgreSQL)
- Python 
  - Pandas
  - Pyscopg3
  - Scrapy 
  - Selenium 


## Procedure

### Step1: Decide what data to collect 
I decided to collect roughly 45k book data from [amazon.ca]( https://www.amazon.ca/ref=nav_logo).
- all books collected are top100 seller books of each category and subcategory. (The ranking might changed after I collected data)


### Step2: collect book data with Python 
I used Scrapy to collect data because Scrapy is much faster than other python libraries for scraping, such as Selenium and Beautiful-Soup.
I successfully collected book ranking, book titles, URLs, and categories of books from amazon.ca. 
However, Scrapy often fails to access individual book URLs despite the URLs are valid.
Therefore, I switched to use selenium to collect informations from each book's URL.
Fortunately, selenium successfully managed the process, but it took a lot of time to complete the scraping process.
At the end, the data I collected has originally roughly **45k** row and **30** columns.

### Step3: store data into SQL database
I heard real-world data stored in databases are often untidy and unclear; this is why data analysis and data scientists sometimes spend a lot of time on data cleaning. To make the project closer to a real data analyst job, I deliberately stored untidy data into SQL database.


### Step4: SQL data cleaning and wrangling
This part was the most challenging coding part.
I cleaned data by following things 
- Removing duplicate
- Changing the data type of variables to a more analyzable form
- Splitting one variable into multiple columns.
- Adding new columns such as estimated revenue of the book (price x estimated_sales)

In the end, I made three queries for amazon audible, kindle and physical books such as hardcover books.


### Step5 data Analysis with tableau public 
I plotted many dashboard(graphs and tables) to show 
- differences between kindle, audible and physical books.
- differences between book genres. 
- differences between book languages.

Details are in the next section.



## Data_Visualization_Analysis

### paper books

#### first dashboard 

![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books.png)
[link to tableau](https://public.tableau.com/views/books1_16676219946510/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link)  

This dashboard shows 
- book genres like Comics, Childrens, Religious& Spiritual books have very high 5-star rating on average which is around 80%. Also, these books tend to have low 1-star ratings on average which is about 2% or less.
- On the other hands, Romance and Mystery&Thrillers have very low 5-star ratings on average which is around 60%. Interestingly their 1-star ratings are not that high. For example, Romance books have lowest 1-star ratings which is 1.28%.
- comparion of the disturbtion of ratings on 4 cateogry of books show, low 5-star rating genres have different distributions from high 5-star ratings genres
  - Low 5-star rating genres have  2 to 3 times more 3 and 4-star ratings on average than high 5-star rating genres although persentage of 1-star ratings on averages are very similar each other. 


### second dashboard 
![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books2.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books2.png)
[link to tableau](https://public.tableau.com/views/books2/Dashboard3?:language=en-US&:display_count=n&:origin=viz_share_link)  

This dashboard shows 
- Book height and width have a positive relationship.
- Book price and thickness also have a positive relationship.
- there are significant differences in the average book price of each book genre.
  - For example, technical books like medicine, law, and textbooks have an above $40 average, but children and romance books averages are around $15.
- Top-ranked books have the highest average estimated revenue and are 93% higher than middle-ranked books.
- Middle ranked books have lower estimated revenue than low-ranked books.

**Why do low rankings have higher avg estimated total revenues than middle-rank books??**
- [this page](https://folgerpedia.folger.edu/BardMetrics_Amazon_sales_rank) shows amazon book ranking mainly based on the number of books sold per day.
- My revenue calculation estimates total revenues based on review numbers and prices.   This calculation does not consider ranking at all, which means 
new books with higher ranking books have lower estimated sales than the lower ranked books but are much older and have more reviews. Therefore, it created different results from our intuition. Higher ranking> more sales.

### third dashboard 
![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books3.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books3.png)
[link to tableau](https://public.tableau.com/views/books3/Dashboard2?:language=en-US&:display_count=n&:origin=viz_share_link)   

This dashboard shows 
- estiamted total sales of each genre of books and Literature type books aredominantly high and this result is consistent with  [a book analysis about popularity](https://bubblecow.com/blog/popular-book-genre).
- Children's book and Medicine also have decently high sales.
- Busienss and Investment book are not really generating a lot of revenue.


### Kindle 

#### first dashboard 


![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/kindle1.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/kindle1.png)
[link to tableau](https://public.tableau.com/views/kindle1/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link)   


The dashboard shows 
- kindle with x-ray tends to have higher estimated earnings than kindle without it.
  -[x-ray](https://www.idownloadblog.com/2021/02/01/x-ray-kindle-paperwhite/)  is a feature that allows the reader to view frequently appearing words and names that make users easy to understand and read books.
- variances of the estimated earnings with and without x-ray are almost identical.
- avg estimated earnings of kindle without x-ray is only 37% of the ones with x-ray.
- the proportion of the datapoint with ad without x-ray is almost 50:50 ratio
- Computer& Internet books have the highest average price, which is $26.59, and the lowest one is Romance, $5.38 
- Compared with physical books, avg prices are lower and especially literature types of books have low average kindle prices 
  - for example,  physical mystery book
  
  
  
 #### second dashboard 


![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/kindle-2.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/kindle-2.png)
[link to tableau](https://public.tableau.com/views/kindle2/Dashboard2?:language=en-US&:display_count=n&:origin=viz_share_link)   

this dashboard shows 
- The overall trend of the ratings of each category of kindles is the same as physical books, but there are some minor differences. 
  For example
  - Erotica kindles have a significantly high 1-star rating of 8% on average, much higher than its rating on physical books.
  - Children's books have above-average 1-star ratings, which is not the case for physical Children's books.
  - The bottom chart shows religious and spiritual kindles have a higher 5-star rating on average than Children's books which is not the case for physical and audiobooks.



### audible 


#### first dashboard 

![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/audible.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/audible.png)
[link to tableau](https://public.tableau.com/views/audible1/Dashboard1?:language=en-US&:display_count=n&:origin=viz_share_link)   

This dashboard shows 
- the price of the audible and length have positive relationships.
 -A possible reason for this is that audible narrators' wages per each book is higher as audible length increases.
- Science Fiction and Fantasy have really high average audible length compared with other book genres.
  - Overall, literature, history, and Christianity books have longer audible lengths than other types of books.
The bottom chart shows the highest estimated revenue of the top rank, but the low-rank book has a slightly higher average than the middle-rank book.
  - Top rank revenue is 45% higher than middle rank's. However, compared with the other types of books, the difference in the estimated revenue of the top-rank books and lower ranks are small. 




#### second dashboard 

![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/audible-2.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/audible-2.png)
[link to tableau](https://public.tableau.com/views/audible2/Dashboard12?:language=en-US&:display_count=n&:origin=viz_share_link)   


This dashboard shows 
- the overall trend of the distributions of 1 and 5 stars ratings among each book genre is consistent with what we found in physical books and kindles.
- Also, the comparison of the distribution of ratings on 4 genres also shows a similar trend as physical books.
 
 
#### third dashboard 


![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/audible-3.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/audible-3.png)
[link to tableau](https://public.tableau.com/views/audible3/Dashboard2?:language=en-US&:display_count=n&:origin=viz_share_link)  


This dashboard shows 
- Average audible length of English book is more than 100 minutes longer than French audiobook.
- distribution of ratings of the English audible and French one shows French book has a 3% lower 5-star rating and 0.5% higher 1-star rating.
  - statistical testing methods like AB testing might help to determine whether or not the differences between 2 languages is significant or not.
- the difference in average audible duration is not a probable factor of the different rating percentages I mentioned above.
  - The main reason is that the scatter plot on the top does not provide a clear relationship between audible length and ratings.

 
#### Summary
- Generally, a high average 5-star rating means books have lower 1-star ratings. Some of the exceptions of this trend are Romance and Mystery&Thriller books.
- Romance and Mystery&Thriller books are pretty unique genres because they generate very high revenues; however, they tend to have very low 5-star ratings compared with other genres of books, but 1-star ratings are also low on average because people tend to give 2 or 3 times more three and 4-stars relative to highly rated books like children's and Religious & Spiritual books. This pattern is observed regardless of the format of books, but the factors of this unique trend are unknown.
- Book rankings of Amazon do not always correspond with the total revenue of books.
- kindle with an x-ray feature have much higher revenue than others without the feature but can not conclude that there is a causal effect of x-ray on revenue.
-  Audible length is positively correlated with the price of the audible. This is presumably due to the wages of narrators per book being higher if the audible duration is longer.
-  Audible in English and French have a similar distribution of each rating, but French ones are slightly lower rated on average. Also, French audible has 100 minutes shorter length than English ones on average, but the difference probably does not cause the difference in ratings between the two languages.  Applying appropriate statistical testing methods will determine whether or not the differences between the two languages are significant. 


### Conclusion 
The dashboards tell Amazon should not always rely on the distribution of ratings to see what books are popular and generating a lot of revenue because ranking and rating do not correspond to each other in the range of rank 1 to 100.
Further analysis is required to test whether or not there is an effect of the 'x-ray' feature on revenue and test statistical significance of differences between ratings of audible in English and French. 



