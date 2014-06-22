Code Book
========================================================

# List of data frames (source, variables, transformations if any)
## activity_labels
### Loaded from ./activity_labels.txt
* activityLabel : integer (further droped in **x3**)
* activityName : character (no factor)


## features
### Loaded from ./features.txt
* featureLabel : integer
* featureName : character (no factor, further used for naming columns)

## subject_train and subject_test
### Respectively loaded from ./train/subject_train.txt and ./test/subject_test
* subjectId : integer

## X_train and X_test
### Respectively loaded from ./train/X_train.txt and ./test/X_test using `read.table.ffdf` function from `ff` package for efficiency
* 561 columns with measured features : numeric<br>
Names are from **features.txt** file

## y_train and y_test
### Respectively loaded from ./train/y_train.txt and ./test/y_test
* activityLabel : integer

## x1
`rbinding` **X_train** and **X_test**

## x2
**x1** with `greping` on column names for keeping those with either *mean* or *std*

## y
`rbinding` **y_train** and **y_test** and `merging` the result with **activity_labels**

## x3
`subseting` y by removing *activityLabel* column and `cbinding` the result with **x2**

## subject
`rbinding` **subject_train** and **subject_test**

## x5

`cbinding` **subject** and **x3**, and applying `colMeans` function grouped by *activityName* and *subjectId* using `ddply` function from `plyr` package.<br>
Writing the **x5** data frame into the **tidy_data_set.txt** file.