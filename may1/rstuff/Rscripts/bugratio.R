a<-read.csv("C:\\Drive E\\Spring2016\\CSC510_Data\\bugratio\\group-m.csv",sep=",",header=F)
B<-c(0,0)
B[1]<-a$V1
B[2]<-a$V2-a$V1
#pie(B, main="group M", col=rainbow(length(B)), labels = c("user 1", "user 2", "user 3"))
pie(B, main="group 6", col=rainbow(length(B)), labels = c("Bug Issues", "No Bug Issues"))
