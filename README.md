# Amazon books analysis

## Table of Contents
- [Overview](#Overview)  
- [Questions_to_answer](#Questions_to_answer)
- [File_Introduction](#File_Introduction)  
- [Technology](#Technology)  
- [Procedure](#Procedure)  
- [Data_Visualization_Analysis](#Data_Visualization_Analysis)
- [Conclusion](#Conclusion)  

## Overview
In this project
- Collected data from Amazon using Python.
- Cleaned and transformed the data gathered into a more useable form by SQL
- Used Tableau-public to visualize data.

## Questions_to_answer
- **Q1 What are the top sold book genres in Canada?**
- **Q2 What book genres have highest/low 5 stars ratings?**
- **Q3 Do customer rating and book price affect sales of books?**

## Hypothesis
- **1 My assumption is self-development books are popular.**
- **2 Best seller books tend to have higher ratings.**
- **3 Yes, customers nowadays consider ratings on purchasing decision making. For example, restaurants, online shopping and Airbnb.**


## Technology 
Programming languages and libraries.
- SQL (PostgreSQL)
- Python 
  - Pandas
  - Pyscopg3
  - Scrapy 
  - Selenium 
 
Data visualisation tool
- Tableau Public

## Data_Visualization_Analysis

### Paper books

#### first dashboard 

#### Figure1: 5_star ratings
![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/top_bottom_5_star.png)

- Comics & Graphic Novels and Children's book have highest 5_star ratings on average.
- Romance and Mystery & Thrillers have lowest 5_star ratings on average.
- there are 20% differences between Top2 and Bottom 2 genres of avg proportion of 5_star ratings.



#### Figure2: AVG Price
![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/avg_price.png)

- Interestingly Romance and Children's book are quite cheap on average.

![https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/books.png](https://github.com/shchuka555/amazon-books-analysis/blob/main/tableau_dashboard/avg_sales.png)


[link to tableau](https://public.tableau.com/views/amazon_book_analysis_physical_book1/Dashboard3?:language=en-US&:display_count=n&:origin=viz_share_link)  




#### Summary
- Generally, a high average 5-star rating means books have lower 1-star ratings. Some of the exceptions of this trend are Romance and Mystery&Thriller books.
- Romance and Mystery&Thriller books are pretty unique genres because they generate very high revenues; however, they tend to have very low 5-star ratings compared with other genres of books, but 1-star ratings are also low on average because people tend to give 2 or 3 times more three and 4-stars relative to highly rated books like children's and Religious & Spiritual books. This pattern is observed regardless of the format of books, but the factors of this unique trend are unknown.
- Book rankings of Amazon do not always correspond with the total revenue of books.
- kindle with an x-ray feature have much higher revenue than others without the feature but can not conclude that there is a causal effect of x-ray on revenue.
-  Audible length is positively correlated with the price of the audible. This is presumably due to the wages of narrators per book being higher if the audible duration is longer.
-  Audible in English and French have a similar distribution of each rating, but French ones are slightly lower rated on average. Also, French audible has 100 minutes shorter length than English ones on average, but the difference probably does not cause the difference in ratings between the two languages.  Applying appropriate statistical testing methods will determine whether or not the differences between the two languages are significant. 


### Conclusion 
Amazon should consider the major literature genres like Romance and Mystery&Thriller as unique regarding the relationship between the rating distribution and estimated revenue.
Further analysis is required to test whether or not there is a causal effect of the 'x-ray' feature on revenue and test the statistical significance of differences between ratings of audible in English and French. 



