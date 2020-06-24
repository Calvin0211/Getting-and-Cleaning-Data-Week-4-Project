---
title: "Calvin"
author: "You"
date: "22/06/2020"
output: 
  html_document: 
    keep_md: yes
---




The files in test and train folder are read into R with the same file names
as the variable object name. These variables are subject_test, features,
subject_X_test, subject_y_test, subject_train, subject_X_train, subject_y_train.

```r
## Reading test data set
subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt")
names(subject_test)<-"id"
features<-read.table("./UCI HAR Dataset/features.txt")
feat1<-features[,2]  ## To get the rownames to be used for both test and train sets 
subject_X_test<-read.table("./UCI HAR Dataset/test/X_test.txt")
names(subject_X_test)<-feat1
subject_y_test<-read.table("./UCI HAR Dataset/test/y_test.txt")
names(subject_y_test)<-"activityType"

## Reading train data set
subject_train<-read.table("./UCI HAR Dataset/train/subject_train.txt")
names(subject_train)<-"id"
subject_X_train<-read.table("./UCI HAR Dataset/train/X_train.txt")
names(subject_X_train)<-feat1
subject_y_train<-read.table("./UCI HAR Dataset/train/y_train.txt")
names(subject_y_train)<-"activityType"
```


The 3 dataframes for test are combined into a new dataframe called test. The 
same thing is done for the training dataframes as well and they are combined 
into a new dataframe called train. 

```r
test<-cbind(subject_test,subject_y_test,subject_X_test)
train<-cbind(subject_train,subject_y_train,subject_X_train)
```


The two dataframes test and train are merged together to form the dataframe data. 
Through logical manipulation only the mean and std variable columns are subsetted
along with the id and activityType variable.

```r
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
```


The activities are originally in numeric 1 to 6 with each value correspnoding 
to a specific activity. This data is available in the file activity_labels. The
file activity_labels is read into the object activity_labels and this object
is used for adding the descriptive activity names to name the activities in the
data set. The actual activity names are substituted instead of 
their corresponding numeric value using a used defined function change1. The 
change1 function.

```r
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
```


The data obtained is then ordered using the id variable.

```r
data3<-data3[order(data3$id,data3$activityType),]
```


This data in data3 object is then split with respect to the id variable and the
result is stored in object n1.

```r
n1<-split(data3,data3$id)
```



A user defined tidy2 function is used to compute the mean of each of the variables
with respect to each individual and what activity they are performing.

```r
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
```

