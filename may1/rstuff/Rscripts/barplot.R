a<-read.csv("C:\\Drive E\\Spring2016\\CSC510_Data\\groupcomment\\grComment.csv",sep=",",header=F)
b<-a$V2
bar<-barplot(b, main="Comments Per Group", xlab="Groups", ylab="No of Comments", names.arg=c("Group 1","Group 2", "Group 3", "Group 4", "Group 5", "Group 6"),
        col="darkgreen",axes=T )
#axis(1, at=bar,labels=c("Group 1","Group 2", "Group 3", "Group 4", "Group 5", "Group 6"),
#     )

