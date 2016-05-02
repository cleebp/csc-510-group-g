a<-read.csv("C:\\Drive E\\Spring2016\\CSC510_Data\\groupEvent\\group-g_event.csv",sep=",",header=F)

weeks<-vector("numeric",30)# total weeks

weekTime<-604800


b<-vector("list",100)
#b[[1]]<-a[1,]
i<-1
j<-1
while(i<=nrow(a)){
  
  if(trimws(a[i,3])=="closed"){
    b[[j]]<-a[i,]
    j<-j+1
  }
  
  i<-i+1
}

totalIssue<-j-1
closeWeek<-vector("numeric",totalIssue) # week which issue closed

##########
minIssue<-b[[1]]
minVal<-minIssue[,2]

i<-2
while(i<=totalIssue){
  temp<-b[[i]]
  if(temp[,2]<minVal)
    minVal<-temp[,2]
  
  i<-i+1
  
}

maxIssue<-b[[1]]
maxVal<-maxIssue[,2]

i<-2
while(i<=totalIssue){
  temp<-b[[i]]
  if(temp[,2]>maxVal)
    maxVal<-temp[,2]
  
  i<-i+1
  
}





start<-minVal


end<-maxVal

i<-0

while(start<=end){
  
  start<-start+weekTime
  i<-i+1
  weeks[i]<-start
  
}

totalWeeks<-i
# counts in which week commit occured
i<-1
while(i<=totalIssue){
  j<-1
  issue<-b[[i]]
  while(issue[,2]>weeks[j]){
    
    j<-j+1
  }
  
  closeWeek[i]<-j
  i<-i+1
  
}

closePerWeek<-vector("numeric",totalWeeks)

#count commits per week


i<-1
while(i<=totalIssue)
{
  index<-closeWeek[i]
  closePerWeek[index]<-closePerWeek[index]+1
  
  i<-i+1
}


plot(closePerWeek,type = "o", col = "darkgreen", xlab = "Weeks", ylab = "Total Issues Closed",
     main = "Issues Closed Per Week of Group 6")
