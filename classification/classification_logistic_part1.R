y<-list(
name=c('Alex','Bob','Claire','Denise'),
female=c('FALSE','FALSE','TRUE','TRUE'),
age=c('20','25','30','35'))
y
y$name [2]

name = c('Alex','Bob','Claire','Denise')
female=c('FALSE','FALSE','TRUE','TRUE')
age=c(20,25,30,35)
df<-data.frame(name,female,age)

rownames(df) <- c('row_1','row_2','row_3','row_4')
df

#Mean age
mean(df$age)

#Claire's Age
df[df$name == 'Claire',3]
