bank <- read.csv('VA Sample Acme Bank.csv')

library(ggplot2)
library(dplyr)

# Group by Industry_Name and calculate the Unpaid_ratio
summarised_bank <- bank %>%
  group_by(industry_name) %>%
  summarise(sum_unpaid_ratio = sum(outstanding_balance, na.rm = TRUE) / sum(original_balance, na.rm = TRUE))

#Summarised data
print(summarised_bank)

#Create the Unpaid_ratio variable in the original dataset
bank$unpaid_ratio <- bank$outstanding_balance / bank$original_balance


#Plot the Bar Chart of Industry vs Unpaid Ratio
ggplot(summarised_bank, aes(x = industry_name, y = sum_unpaid_ratio)) +
  geom_bar(stat = "identity") +
  scale_x_discrete(guide = guide_axis(n.dodge = 3)) +
  labs(x = "Industry", y = "Unpaid Ratio", title = "Unpaid Ratio by Industry")

#Unpaid Ratio of the mining industry = .625

corr_df <- bank %>% 
  select(adverse_capital_ratio, baseline_capital_ratio, capital_ratio, unpaid_ratio)

# Calculate the correlation matrix
corr_matrix <- cor(corr_df, use = "complete.obs")

#Correlation Index between Adverse_capital_ratio & Baseline_Capital_Ratio : .879

# Correlation Plot
print(corr_matrix)
install.packages("corrplot")
library(corrplot)
corrplot(corr_matrix, method = "circle")

# Summarise by loan type
loan_summary <- bank %>%
  group_by(loan_type) %>%
  summarise(count = n())

# Pie chart
loan_summary$fraction <- loan_summary$count / sum(loan_summary$count)
loan_summary$percentage <- round(100 * loan_summary$fraction, 1)

ggplot(loan_summary, aes(x = "", y = fraction, fill = loan_type)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y") +
  geom_text(aes(label = paste0(percentage, "%")), position = position_stack(vjust = 0.5)) +
  labs(title = "Loan Type Distribution")

# Term loan occupies approximately 70% of the pie

# Create a treemap for Loan_Type

install.packages("treemap")
library(treemap)

treemap(bank,
        index = "loan_type",
        vSize = "loan_type",  # Adjust as needed for actual size variable
        vColor = "loan_type",
        type = "index",
        title = "Treemap of Loan Type")

# Summarize the data by loan type
loan_summary <- bank %>%
  group_by(loan_type) %>%
  summarise(count = n())

# Calculate the percentage for each loan type
loan_summary$percentage <- (loan_summary$count / sum(loan_summary$count)) * 100

# Create a Treemap
treemap(loan_summary,
        index = "loan_type",     
        vSize = "percentage",    
        vColor = "loan_type",    
        type = "index",          
        title = "Treemap of Loan Types")

library(ggplot2)

# Create a boxplot
boxplot(bank$return_percent, outline = FALSE, 
        main = "Boxplot of Return Percent (Without Outliers)",
        ylab = "Return Percent")

#The boxplot appears symmetical
