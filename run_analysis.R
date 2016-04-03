# File: run_analysis.R

# Load dplyr library
library(dplyr)

# Check if directory exists.  If it does not, then create it.
if (!dir.exists("./data")) {
    dir.create("./data")
}

# Set working directory
setwd("./data")

# Set URL to downlaod
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Zip file name
zippedfile <- "FUCI_HAR_Dataset.zip"

# Downlaod file and unzip
download.file(url, zippedfile)
unzip(zippedfile)

# Set working directory to location of downloaded data
setwd("UCI HAR Dataset")

# Load the activity labels file into a data frame and set the columns names to "id" and "label"
activitylabels <- read.table("activity_labels.txt")
colnames(activitylabels) <- c("id", "label")

# Load the features file.  This file contains the column names (i.e. features) of the data. 
features <- read.table("features.txt", stringsAsFactors = FALSE)

# Load the test dataset and set the column names to the list of features
xtest <- read.table("test/X_test.txt")
colnames(xtest) <- features[,2]

# Load the activity associated with the test data and set column name to "activity"
ytest <- read.table("test/y_test.txt")
colnames(ytest) <- c("activity")

# Load the subjects associated with the test data and set column name to "subject"
subjecttest <- read.table("test/subject_test.txt")
colnames(subjecttest) <- c("subject")

# Bind all test data together (test data, activity, subject) to form the complete test dataset
xtestcomplete <- cbind(ytest, subjecttest, xtest)

# Load the training dataset and set the column names to the list of features
xtrain <- read.table("train/X_train.txt")
colnames(xtrain) <- features[,2]

# Load the activity associated with the training data and set column name to "activity"
ytrain <- read.table("train/y_train.txt")
colnames(ytrain) <- c("activity")

# Load the subjects associated with the training data and set column name to "subject"
subjecttrain <- read.table("train/subject_train.txt")
colnames(subjecttrain) <- c("subject")

# Bind all training data together (training, activity, subject) to form the complete training dataset
xtraincomplete <- cbind(ytrain, subjecttrain, xtrain)

# Vertically merge the two datasets together
xmergeddata <- rbind(xtestcomplete, xtraincomplete)

# Extract only the measurements for standard deviation and mean.  Also include the subject
# and activity, since these will be needed to group by later.
stdandmean <- xmergeddata[ , grepl("^subject?|^activity?|mean\\(\\)|std\\(\\)", colnames(xmergeddata))]

# Assign the descriptve activity names (labels) to the dataset
stdandmean$activity <- activitylabels[match(stdandmean$activity, activitylabels$id), 2]

# Use descriptive variable names following the guidleines outlined in online lecture notes
colnames(stdandmean) <- gsub("^t", "time", colnames(stdandmean))
colnames(stdandmean) <- gsub("^f", "frequency", colnames(stdandmean))
colnames(stdandmean) <- gsub("Acc", "acceleration", colnames(stdandmean))
colnames(stdandmean) <- gsub("Gyro", "gyroscope", colnames(stdandmean))
colnames(stdandmean) <- gsub("Mag", "magnitude", colnames(stdandmean))
colnames(stdandmean) <- gsub("BodyBody", "body", colnames(stdandmean))
colnames(stdandmean) <- tolower(colnames(stdandmean))

# Calculate the average of each mean and std variable for each activity and subject
tidydata <- stdandmean %>% group_by(activity,subject) %>% summarise_each(funs(mean),-subject,-activity)

# Write tidydata output to file
write.table(tidydata, file = "tidydata.txt", row.names = FALSE)
