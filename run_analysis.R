setwd("C:/Users/calvin/Desktop/Vacation Study Calvin/Getting and Cleaning DATA/Week 4/Week 4 Project Getting and Cleaning Data")

## Reading test data set
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test)<-"id"
features<-read.table("./UCI HAR Dataset/features.txt")
feat1<-features[,2]  ## To get the rownames to be used for both test and train sets 
subject_X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
names(subject_X_test)<-feat1
subject_y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
names(subject_y_test)<-"activityType"
test<-cbind(subject_test,subject_y_test,subject_X_test)

## Reading train data set
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train)<-"id"
subject_X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
names(subject_X_train)<-feat1
subject_y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
names(subject_y_train)<-"activityType"
train<-cbind(subject_train,subject_y_train,subject_X_train)

## Merging Both data Sets
data<-rbind(test,train)
library(plyr)
data<-arrange(data,id)

## The data set which contains only the measurements of mean and standard deviation
d1<-grepl("mean",names(data))
d2<-grepl("std",names(data))
d3<-d1 | d2
data1<-data[,d3]   ## For mean and std columns
data2<-data[,c(1,2)]  ## For id and activity label columns
data3<-cbind(data2,data1) ## The desired data set


##Descriptive activity names to name the activities in the data set
activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt")
numbervalues1<-as.character(activity_labels[,1])

correspondingActivity1<-as.character(activity_labels[,2])

change1<-function(x,y,z)
{
        l<-length(y)
        for(i in 1:l)
        {
                d=z[i]
              x<-gsub(pattern=i,replacement = d ,x)  
        }
        x
}
data3[,2]<-change1(x=data3[,2],y=numbervalues1,z=correspondingActivity1)
data3<-data3[order(data3$id,data3$activityType),]

##An  independent tidy data set with the average of each variable for each 
##activity and each subject.
n1<-split(data3,data3$id)
tidy2<-function(x)  
{
        l1<-length(x)
        y<-data.frame(id=rep(c(1:30),each=6),activityType=correspondingActivity1)
        y[,1]<-as.factor(y[,1])
        k=1
        for(i in 1:l1)
        {
                n2<-split(x[[i]],x[[i]]$activityType)
                l2<-length(n2)
                for(j in 1:l2)
                {
                     
                     t3<-colMeans(n2[[j]][sapply(n2[[j]], is.numeric)])
                     t3<-as.numeric(t3)
                     y[k,c(3:81)]<-t3[2:80]
                     k=k+1
                }
        }
        y
}
tidydata<-tidy2(n1)
names(tidydata)<-names(data3) 
write.table(tidydata,file = "tidydata.txt",sep = "")
write.csv(tidydata,file = "tidydata.csv",row.names = FALSE)

