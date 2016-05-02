a<-read.csv("C:\\Drive E\\Spring2016\\CSC510_Data\\groupCommit\\group-m_commits.csv",sep=",",header=F)


weeks<-vector("numeric",30)# total weeks
totalCommits<-nrow(a)

weekTime<-604800

commitWeek<-vector("numeric",totalCommits) # week which commit occur

start<-a[totalCommits,2]

end<-a[1,2]
i<-0

while(start<=end){
  
  start<-start+weekTime
  i<-i+1
  weeks[i]<-start
  
}

totalWeeks<-i
# counts in which week commit occured
i<-totalCommits
while(i>=1){
  j<-1
  while(a[i,2]>weeks[j]){
    
    j<-j+1
  }
  
  commitWeek[i]<-j
  i<-i-1
  
}

commitPerWeek<-vector("numeric",totalWeeks)

#count commits per week


i<-1
while(i<=totalCommits)
{
  index<-commitWeek[i]
  commitPerWeek[index]<-commitPerWeek[index]+1
  
  i<-i+1
}


plot(commitPerWeek,type = "o", col = "darkgreen", xlab = "Weeks", ylab = "Total Commits",
     main = "Commits Per Week of Group 6")
