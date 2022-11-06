library(tidyverse)
library(data.table)
df = read_csv('cglist_analysis/scraping/book_items.csv')


  
df[  df['dist_rating'] %like% 'star'] 

df2 = df[1:29000,]
write.csv(df2,'cglist_analysis/scraping/book_items_sql.csv',row.names = TRUE, na= "NaN")




df3 = df2 %>%
  group_by(productTitle, price,numberOfReview,bookType) %>%
  summarize(count = n()) %>%
  filter(count > 1 ) %>%
  order_by()

df3 = df2 %>%
  filter(author == 'Kayleigh King')

write.csv(df2,'cglist_analysis/scraping/book_items_sql.csv',row.names = TRUE, na= "NaN")
df[8970,]['dist_rating']

