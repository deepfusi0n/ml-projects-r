df <- read.csv('Movies raw.csv')
df$gross <-gsub('[,]',"",df$gross)
df$votes <-gsub('[,]',"",df$votes)

