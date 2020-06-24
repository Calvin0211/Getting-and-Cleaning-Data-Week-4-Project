# Getting-and-Cleaning-Data-Week-4-Project
The files in test and train folder are read into R with the same file names
as the variable object name. These variables are subject_test, features,
subject_X_test, subject_y_test, subject_train, subject_X_train, subject_y_train.

The 3 dataframes for test are combined into a new dataframe called test. The 
same thing is done for the training dataframes as well and they are combined 
into a new dataframe called train. 

The two dataframes test and train are merged together to form the dataframe data. 
Through logical manipulation only the mean and std variable columns are subsetted
along with the id and activityType variable.

The activities are originally in numeric 1 to 6 with each value correspnoding 
to a specific activity. This data is available in the file activity_labels. The
file activity_labels is read into the object activity_labels and this object
is used for adding the descriptive activity names to name the activities in the
data set. The actual activity names are substituted instead of 
their corresponding numeric value using a used defined function change1. The 
change1 function.

The data obtained is then ordered using the id variable.

This data in data3 object is then split with respect to the id variable and the
result is stored in object n2.

A user defined tidy2 function is used to compute the mean of each of the variables
with respect to each individual and what activity they are performing.

The tidy data is uploaded as an excel file named tidydata
