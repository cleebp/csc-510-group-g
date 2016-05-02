
a<-read.csv("C:\\Drive E\\Spring2016\\CSC510_Data\\changes_per_commit\\group-m.csv",sep=",",header=F)


b<-a$V2
b<-gsub(",", "", b)#remove ,
b<-as.numeric(b)
hist(b, main=toupper("Changes per commit of Group 6"), 
     font.main=3,  xlab="Changes Per Commit", ylab="Frequency", font.lab=3, col="darkgreen")