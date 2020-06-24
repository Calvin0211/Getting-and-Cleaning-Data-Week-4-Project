---
title: "Codebook"
author: "Calvin Joseph"
date: "24/06/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

subject_test: This object has the data of subject_test file
subject_X_test: This object has the data of subject_X_test file
subject_y_test: This object has the data of subject_y_test file

subject_train: This object has the data of subject_train file
subject_X_train: This object has the data of subject_X_train file
subject_y_train: This object has the data of subject_y_train file

features: This object has the data of features file
feat1: This object has the rownames to be used for both test and train sets 
test: This object has the data of all the files in test folder
train: This object has the data of all the files in train folder
data: This object is obtained by merging train and test objects
d1: Logical vector whether the names of dataset data has mean
d2: Logical vector whether the names of dataset data has std
d3: logical vector whether the names of dataset data has mean or std
data1: dataframe of the data object which has only mean and std columns
data2: dataframe of the data object which has std and activity label columns
data3: The dataframe obtained by combining data1 and data2 object. The reultant
        data set
activity_labels: This object has the data of activity_label file
numbervalues1: Vector of the numbers in activity_label file
correspondingActivity1: Character vector of the activity with respect to the 
                        numeric value in numbervalues1
change1: The actual activity names are substituted instead of their corresponding 
         numeric value using a used defined function called change1.
n1: The object where data3 object is split with respect to the id variable
tidy2: tidy2 function is used to compute the mean of each of the variables with 
       respect to each individual and what activity they are performing.


