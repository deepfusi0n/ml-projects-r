library(tidyverse)
profile <- read_csv('profile.csv')

############ Question 1 ##################

any(is.na(profile))
#Answer: There are no missing values


############ Question 2 ##################

is.numeric(profile$CNT_TBM)
#Answer: The data type of CNT_TBM is numeric

############ Question 3 ##################

par(mfrow = c(2, 3))

hist(profile$CNT_ATM, main = "CNT_ATM", col = 'orange')
hist(profile$CNT_CSC, main = "CNT_CSC", col = "tomato")
hist(profile$CNT_POS, main = "CNT_POS", col = "lightgreen")
hist(profile$CNT_TBM, main = "CNT_TBM", col = "skyblue")
hist(profile$CNT_TOT, main = "CNT_TOT", col = "purple")


#These are right skewed.

############ Question 4 ##################

par(mfrow = c(1, 3))
hist(profile$CNT_ATM, main = "CNT_ATM", breaks = 100)
hist(profile$CNT_POS, main = "CNT_POS",  breaks = 100)
hist(profile$CNT_TOT, main = "CNT_TOT", breaks = 300)

############ Question 5 ##################

library(moments)
skewness(profile$CNT_ATM)
skewness(profile$CNT_CSC)
skewness(profile$CNT_POS) 
skewness(profile$CNT_TBM)
skewness(profile$CNT_TOT)

#These distributions are highly skewed

#We must transform the data for k-means clustering, 
#due to the high level of skewness


############ Question 6 ##################

LGT_ATM <- log((profile$CNT_ATM) / ((profile$CNT_TOT - profile$CNT_ATM)))
LGT_CSC <- log((profile$CNT_CSC) / ((profile$CNT_TOT - profile$CNT_CSC)))
LGT_POS <- log((profile$CNT_POS) / ((profile$CNT_TOT - profile$CNT_POS)))
LGT_TBM <- log((profile$CNT_TBM) / ((profile$CNT_TOT - profile$CNT_TBM)))

############ Question 7 ##################

skewness(LGT_ATM)
skewness(LGT_CSC)
skewness(LGT_POS)
skewness(LGT_TBM)

#Skewness:
#LGT_ATM = -0.2645857
#LGT_CSC = 0.2037676
#LGT_POS = 0.1934033
#LGT_TBM = 0.3506887

############ Question 8 ##################

new_df <- data.frame(
  LGT_ATM = LGT_ATM,
  LGT_CSC = LGT_CSC,
  LGT_POS = LGT_POS,
  LGT_TBM = LGT_TBM
)

scale(new_df)

new_df <- scale(new_df)
############ Question 9 ##################


set.seed(746)
customer_clusters <- kmeans(new_df, centers = 4)
print(customer_clusters)
customer_clusters$size

############ Question 10 ##################

#Clusters one and two has 35,611 and 27,026 customers respectively
#Clusters three and four has 21,066 and 16,267 customers respectively 

############ Question 11 #################
pie(customer_clusters$size, main="Cluster Sizes", col=rainbow(4))

#The largest cluster is cluster 1 , LGT_ATM

############ Question 12 ################
profile$Cluster <- customer_clusters$cluster

means_by_cluster <- aggregate(cbind(CNT_TBM, CNT_ATM, CNT_POS, CNT_CSC) ~ Cluster, data=profile, mean)

print(means_by_cluster)
#Cluster   CNT_TBM   CNT_ATM   CNT_POS   CNT_CSC
#       1  46.65297 15.115190  9.343602 11.951532
#      2 113.59935  7.116147  2.822911  3.937653
#     3  45.34269 34.654775  4.083927  2.991599
#    4  69.15457 30.026753 42.785237  4.501749

############# Question 13 ###############

#ATM Customers: Segment #2
#Service Customers: Segment #3
#Traditional Customers: Segment #4
#Point of Sale Customers: Segment #1

############ Question 14 ################
profile$LGT_ATM <- log((profile$CNT_ATM) / ((profile$CNT_TOT - profile$CNT_ATM)))
profile$LGT_CSC <- log((profile$CNT_CSC) / ((profile$CNT_TOT - profile$CNT_CSC)))
profile$LGT_POS <- log((profile$CNT_POS) / ((profile$CNT_TOT - profile$CNT_POS)))
profile$LGT_TBM <- log((profile$CNT_TBM) / ((profile$CNT_TOT - profile$CNT_TBM)))
short_profile <- profile[1:1000, ]
logit_vars <- short_profile[, c("LGT_ATM", "LGT_CSC", "LGT_POS", "LGT_TBM")]

set.seed(123)

hc_mod <- hclust(dist(logit_vars), method = "ward.D2") 


plot(hc_mod, labels = FALSE, main = "Dendrogram of Hierarchical Clustering")
rect.hclust(hc_mod, k = 4, border = "red")

############ Question 15  ################
short_profile$Cluster_HC <- cutree(hc_mod, k = 4)
means_by_hc_cluster <- aggregate(cbind(CNT_TBM, CNT_ATM, CNT_POS, CNT_CSC) ~ Cluster_HC, data=short_profile, mean)
print(means_by_hc_cluster)

#  Cluster_HC   CNT_TBM   CNT_ATM   CNT_POS   CNT_CSC
#          1  39.73559 14.525424  6.555932 10.559322
#          2 102.73817  5.955836  3.914826  4.687697
#          3  53.36139 32.648515  4.009901  2.341584
#          4  62.59677 29.032258 41.172043  8.967742

############ Question 16 ################

print(head(short_profile, 10))
#The means are relatively similar between k-means and hierarchical clustering
