library(tidyverse)

#Task 1
df <- read.csv('movies_clean2.csv')
interests <- df %>% select(score, votes, budget, gross, runtime)

interests_scaled <- as.data.frame(
  lapply(interests, function(x) scale(x, center = TRUE, scale = TRUE)))

#Task 2
RNGversion ("3.5.2")
set.seed(123)

kmeans_result <- kmeans(interests_scaled, 3)

#Task 3
#cluster size
print('Number of movies in each cluster:')
table(kmeans_result$cluster)

#scaled centers
print('\nCluster Centers (Scaled data):')
kmeans_result$centers

df$cluster <- kmeans_result$cluster

#each cluster's respective mean value
cluster_means <- aggregate(interests, by=list(Cluster=df$cluster), FUN=mean)
print("\nCluster Means (Original Scale):")
print(cluster_means)

#number of movies in each cluster
cluster_sizes <- table(df$cluster)
print("Number of movies in each cluster:")
print(cluster_sizes)

#Which cluster has relatively higher quality (score), budget, and runtime?
##Cluster 3 has a relatively higher quality score, budget, and runtime.

#Which cluster has relatively lower quality (score), budget, and runtime?
##Cluster 2 has a relatively lower quality score, budget, and runtime.

#Which cluster has relatively lower budget and gross, but still get pretty good quality ratings (score)?
##Cluster 1 has a relatively lower budget and gross, but still gets pretty good quality ratings.

#Task 4
#Aggregate clusters by years
yearly_analysis <- df %>%
  group_by(year) %>%
  summarise(
    cluster1 = sum(cluster == 1),
    cluster2 = sum(cluster == 2),
    cluster3 = sum(cluster == 3))

#Results
print("Number of movies in each cluster by year:")
print(yearly_analysis)
