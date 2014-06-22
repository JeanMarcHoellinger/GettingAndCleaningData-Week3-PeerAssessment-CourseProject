# Load activity labels
activity_labels <- read.table(
        "./activity_labels.txt", 
        sep = ' ', 
        stringsAsFactors = FALSE, 
        colClasses = c("integer", "character"),
        col.names = c("activityLabel", "activityName")
        )

# Load features
features <- read.table(
        "./features.txt", 
        sep = ' ', 
        stringsAsFactors = FALSE, 
        colClasses = c("integer", "character"),
        col.names = c("featureLabel", "featureName")
        )

# Load subject training, subject test, X training, X test, y training and y test
# Using assign and paste functions to create dynamic variables (data frame names)
library(ff)
for (type in c("train", "test")) {
        assign(paste("subject_", type, sep = ''),
               read.table(
                       paste(".", type, paste("subject_", type, ".txt", sep = ''
                                              ), sep = '/'),
                       stringsAsFactors = FALSE,
                       colClasses = "integer",
                       col.names = "subjectId"
                       )
               )
        
# Use of read.table.ffdf function from ff package as read.table overflows memory
        assign(paste("X_", type, sep = ''), 
               as.data.frame(read.table.ffdf(
                       file=paste(".", type, paste("X_", type, ".txt", sep = ''
                                                   ), sep = '/'),
                       header = FALSE,
                       VERBOSE=TRUE, 
                       colClasses = rep("numeric", times = nrow(features)),
                       
# Using of descriptive activity names to name the activities in the data set (cf 3.)
                       col.names = features[, "featureName"]
                       ))
               )
        assign(paste("y_", type, sep = ''),
               read.table(
                       paste(".", type, paste("y_", type, ".txt", sep = ''
                                              ), sep = '/'),
                       stringsAsFactors = FALSE,
                       colClasses = "integer",
                       col.names = "activityLabel"
               )
        )
}

# Merging the training and the test sets to create one data set (cf 1.)
x1 <- rbind(X_train, X_test)

# Extracting only the measurements on the mean and standard deviation for each 
# measurement (cf 2.) 
x2 <- x1[, grepl("mean|std", features[, "featureName"])]

# Appropriately labeling the data set with descriptive variable names (cf 4.)
y <- merge(rbind(y_train, y_test), activity_labels)
x3 <- cbind(subset(y, select = -activityLabel), x2)

# Creating a second, independent tidy data set with the average of each variable
# for each activity and each subject (cf5.)
subject <- rbind(subject_train, subject_test)
library(plyr)
x5 <- ddply(cbind(subject, x3), c("activityName", "subjectId"), function(x) 
            colMeans(subset(x, select = c(-activityName, -subjectId))))
write.table(x5, file = "../tidy_data_set.txt", row.names = FALSE)
