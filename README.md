GettingAndCleaningData-Week3-PeerAssessment-CourseProject
=========================================================
## Environment
Set the working directory where the Samsung data is.
## Load
The two first `read.table` functions load respectively the following data frames :
* activity_labels
* features

The `for` loop saves code to load the six following data frames :
* subject_train
* subject_test
* X_train
* X_test
* y_train
* y_test

by using *type* variable in combination with `assign` and `paste` functions

**X_training** and **X_test** files overflow memory when loaded with `read.table`
function.<br>
`read.table.ffdf` function from `ff` package is used instead. 

## Uses descriptive activity names to name the activities in the data set (cf 3.)
Columns names of **X_train** and **X_test** data frames are filled from 
**features** data frame.

## Merges the training and the test sets to create one data set (cf 1.)
**X_train** and **X_test** data frames are merged in a single one (**x1**) with 
`rbind` function as they have the same structure.

## Extracts only the measurements on the mean and standard deviation for each measurement (cf 2.)
A new data frame (**x2**) is created from **x1**, keeping only columns having 
**mean** or **std** in their names with `grepl` function.

## Appropriately labels the data set with descriptive variable names. (cf 4.)
A new data frame (**x3**) is created from merging **y_train**, **y_test** and 
**activity_labels** data frames to get descriptive variables names. The result is
combined with columns from **x2** without *activityLabel* column.

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject (cf5.)
A new data frame (**x5**) is created from combining the *subjectId* column from 
**subject** data frame and all columns from **x3**, and applying `colMeans` 
function grouped by *activityName*, *subjectId* columns.

**x5** data frame is finally writen into the **tidy_data_set.txt** file.