# Amazon books analysis

## Table of Contents
- [Overview](#Overview)  
- [Questions_to_answer](#Questions_to_answer)
- [Hypothesis](#Hypothesis)
- [Technology](#Technology)  
- [Procedure](#Procedure)  
- [Data_Visualization_Analysis](#Data_Visualization_Analysis)
- [Conclusion](#Conclusion)  

## Overview
In this project
- Utilized Python to Collect the top 100 popular book data for each book subcategory on Amazon.ca.
The data collection was conducted at the end of October 2022. 
- Cleaned and transformed the data gathered into a more useable and analyzable form by SQL.
- Filtered and then visualized physical book data on Tableau-public dashboards.
- Answered the below questions using the dashboards.

## Questions_to_answer
- **Q1 What are the top sold book genres in Canada?**
- **Q2 What book genres have highest/low 5 stars ratings?**
- **Q3 Do customer rating and book price affect sales of books?**

## Hypothesis
- **1 Self-development books are one of the top-seller genres.**
- **2 Bestseller books tend to have higher ratings.**
- **3 Rating is a big purchasing factor for customers nowadays because many people check reviews before buying goods and services. For example, restaurants, online shopping and Airbnb.**


## Technology 
Programming languages and libraries.
- SQL (PostgreSQL)
- Python 
  - Pandas
  - Pyscopg3
  - Scrapy 
  - Selenium 
 
Data visualisation tool.
- Tableau Public

## Data_Visualization_Analysis
[link to tableau for figure 1](https://public.tableau.com/views/amazon_book_analysis_physical_book1/Dashboard3?:language=en-US&:display_count=n&:origin=viz_share_link)

[link to tableau for figure 2~4](https://public.tableau.com/views/amazon_book_analysis_physical_book1/Dashboard3?:language=en-US&:display_count=n&:origin=viz_share_link) 

#### Figure1: Estimated Total Sales
![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/all_genre_sales.png)
- Assuming 5% of customers who purchased a book rated a book, the estimation was calculated by ( review_number X price ) / 5. 
- The result is generally consistent with [a popularity book analysis](https://bubblecow.com/blog/popular-book-genre)


#### Figure2: Percentage of 5_star Ratings.
![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/top_bottom_5_star.png)
- The top 2 5_star rated genres are Comics & Graphic Novels and Children's books. Above 80% of reviews are 5_star for these genres.
- Romance and Mystery & Thrillers have bottom 2 5_star ratings on average which is around 60%.
- there are 20% differences between the Top 2 and Bottom 2 book genres.

#### Figure3: Avg Price
![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/avg_price.png)
- There is not a clear relationship between book price and 5_star ratings.

#### Figure4: Estimated Total sales of top5 and bottom5 5_star rated genres.
![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/avg_sales.png)
- Clearly, the figure explains that Romance and Mystery & Thrillers are the most popular and top-sold genres despite having the lowest percentage of 5-star ratings among all genres of books.




#### Answer to the question.



### Conclusion 
Amazon should consider the major literature genres like Romance and Mystery&Thriller as unique regarding the relationship between the rating distribution and estimated revenue.
Further analysis is required to test whether or not there is a causal effect of the 'x-ray' feature on revenue and test the statistical significance of differences between ratings of audible in English and French. 



