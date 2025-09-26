#Question 1 : Use a Bar chart to Explore the relationship between rating & gross

movies <- read.csv('Movies Clean.csv')

#Use a Bar chart to Explore the relationship between rating and gross

movies$rating
movies$Popularity <- ifelse(movies$rating > 6.5, "Good", "Bad")

library(dplyr)

# Popularity and Gross
avg_gross_table <- movies %>%
  group_by(Popularity) %>%
  summarize(average_gross = mean(gross, na.rm = TRUE))

print(avg_gross_table)

#Create a bar chart from the table above.

library(ggplot2)

# Creating the bar chart
ggplot(avg_gross_table, aes(x = Popularity, y = average_gross)) +
  geom_bar(stat = "identity", fill = "skyblue") + 
  labs(title = "Gross by Popularity", x = "Popularity", y = "Average Gross") +
  theme_minimal()

#Does Good movie have a higher gross?
#Answer: Yes
----------------------------------------------------------------------------
#Question 2: Runtime & Gross Scatterplot
#(1)  

plot(runtime ~ gross, data=movies)
  
#Add a trendline 
  
ggplot(data = movies,
         mapping = aes(x = gross, y = runtime)) +
geom_point(color = "cornflowerblue",alpha = .7,size = 3) +
geom_smooth(method = "lm")

#(2)
#Do I think a longer runtime assoicated with a higher gross?
##Yes
