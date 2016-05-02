a<-read.csv("C:\\Drive E\\Spring2016\\CSC510_Data\\changes_made\\group-b.csv",sep=",",header=F)
B<-a$V2
#pie(B, main="group 6", col=rainbow(length(B)), labels = c("user 1", "user 2", "user 3"))
pie(B, main="Group 1", col=rainbow(length(B)), labels = c("user 1", "user 2", "user 3", "user 4"))
#pie(B, main="group L", col=rainbow(length(B)), labels = c("user 1", "user 2", "user 3", "user 4", "user 5"))