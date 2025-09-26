library(arules)
#A

#Q1: read csv

df <- read.csv('transactions.csv')

#We cannot use read.csv to import this data because this is a data set with 
#trasactions , it is not structured to use transaction data

# Q2: Import transaction data
trans <- read.transactions("transactions.csv", format = "basket", sep = ",")
summary(trans)
#There are 20,000 transactions with 17 distinct items

#Q3: First five rows
inspect(trans[1:5])

#[1] {Candy Bar}     
#[2] {Pain Reliever} 
#[3] {Toothpaste}    
#[4] {Bow}           
#[5] {Greeting Cards}


#Question 4: Calculate support for all items
item_freq <- itemFrequency(trans)
item_freq


#  Bow        Candy Bar        Deodorant   Greeting Cards         Magazine          Markers 
#0.054645         0.171005         0.005420         0.146885         0.241305         0.008070 
#Pain Reliever      Pencils      Pens          Perfume Photo    Processing Prescription Med 
#0.026700         0.134925         0.143575         0.089960         0.058480         0.014505 
#Shampoo             Soap      Toothbrush       Toothpaste   Wrapping Paper 
#0.033800         0.043025         0.067350         0.160425         0.050990 

#Support for perfume
perfume_support <- item_freq["perfume"]
#Suport for perfume is equal to .089960 or 9%, meaning perfume is in 9% of all transactions

#Question 5: 

pie(sort(item_freq, decreasing = TRUE), main = "Item Frequencies")

#Question 6: 
sorted_freq <- sort(itemFrequency(trans), decreasing = TRUE)

top10 <- head(sorted_freq, 10)

barplot(top10,
        main = "Top 10 Most Frequent Items", ylab = "Support (Frequency)",
        las = 2, 
        cex.names = 0.7)  
#B

#Question 7:
transactionrules <- apriori(trans, parameter = list(supp = 0.001, conf = 0.25, 
                                                    minlen = 2))

#Question 8:
summary(transactionrules)
#321 rules were generated

#Question 9:
#177 rules include 3 items

#Question 10: 
top_rules <- sort(transactionrules, by = "lift", decreasing = TRUE)
inspect(head(top_rules, 3))

#Question 11:
frequent_pairs <- apriori(trans, 
                          parameter = list(supp = 0.001,
                                           maxlen = 2,
                                           target = "frequent itemsets"))
inspect(sort(frequent_pairs, by = "support", decreasing = TRUE)[1:5])

#Question 12:
#These two have the same support value becuase pens are normally bought. with
#Greeting cards so people can write with them.

#Question 13:
rowSums(as(rhs(transactionrules), "ngCMatrix"))

#The four items that appear most frequently are:
#Magazines, Candy Bar, Toothpaste, and Greeting Cards 

#Question 14:
transactionrules2 <- apriori(trans, 
                             parameter = list(supp = 0.001,
                                              conf = 0.1,
                                              minlen = 2,
                                              maxlen = 2))
#Question 15: 
#There are 44 rules

#Question 16:
transactionrules2 <- apriori(trans, 
                             parameter = list(supp = 0.001,
                                              conf = 0.1,
                                              minlen = 2,
                                              maxlen = 2))

perfume_rules <- subset(transactionrules2, lhs %in% "Perfume" | rhs %in% "Perfume")

inspect(sort(perfume_rules, by = "lift", decreasing = TRUE))
#The highest association with perfume is toothbrush

#Question 17:
#These two have the same support and lift values because they contain the same items

#Question 18: 
#The last two items seem to have a negative association since the lift is .791883

#Question 19:
#Toothbrush => perfume has the highest confidence
#Of all customers who buy Toothbrush, 32.40% also buy Perfume

#C
install.packages("arulesViz")
library(arulesViz)

plot(transactionrules, measure = "support", engine = "plotly")
#Nodes that have high confidence tend to have several items in their transactions
#Meanwhile nodes that have high support have a few items in their transactions,
#only one or two items can be found in these transactions
