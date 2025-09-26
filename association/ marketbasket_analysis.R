###################### Mini Project 4 ##################################
library(tidyverse)
library(rpart)
library(rpart.plot)

# Task 1: Data Preparation (10 pts)
movies_clean <- read.csv('movies_clean2.csv')


df <- movies_clean %>%
  select(rating, genre, year, score, votes, budget, runtime, gross)

df$rating <- as.factor(df$rating)
df$genre <- as.factor(df$genre)

# Split the data into training and testing sets
train_df <- df[1:4000, ]  
test_df <- df[4001:nrow(df), ] 

# Task 2: Decision Tree Modeling 
model_rpart <- rpart(gross ~ rating + genre + year + score + votes + budget + runtime, 
                     data = train_df, method = "anova")

summary(model_rpart)

# Task 3: Model Visualization 
# Visualize the regression tree structure using rpart.plot
rpart.plot(model_rpart)

# Task 4: From the Visualization, Interpret the Insights 
# The key factors are Votes and Budget, with the most important being votes

# Task 5: Evaluate the Testing Stage 
#Predictions:
predictions_rpart <- predict(model_rpart, test_df)


#Mean Absolute Error (MAE) function to evaluate model performance
mae_function <- function(actual, predicted) {
  mean(abs(actual - predicted))
}

# Calculate the Mean Absolute Error (MAE) on the test data
mae_value <- mae_function(test_df$gross, predictions_rpart)
print(paste("Mean Absolute Error (MAE):", round(mae_value, 2)))
