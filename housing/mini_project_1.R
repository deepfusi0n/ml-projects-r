df <- read.csv('Movies raw.csv')
df$votes <-gsub("[[:punct:]]","",df$votes) #remove ,
df$gross <-gsub("M","",df$gross) #remove M
df$gross <-gsub("[$]","",df$gross) #remove $
df$gross<-as.numeric(df$gross) # type transform
df$votes<-as.numeric(df$votes) # type transform
df<-na.omit(df)

install.packages("dplyr")
library(dplyr)
df_2 <- df %>% select(-one.line)
write.csv(df_2, file="/Users/joshnation/Desktop/BI-Fall2024/Mini_Project_1.csv", row.names = FALSE)


