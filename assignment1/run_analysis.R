# use data.table and reshape2 libraries
library(data.table)
library(reshape2)
# create a tempfile and a tempdir
tmpFile <- tempfile()        
tmpdir <- tempdir()
# download the data to the tmpFile
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile=tmpFile, method="curl")
# unzip to tmpDir
unzip(tmpFile, exdir = tmpdir)
# name the extracted files
# datasets
X_test_dat_file           <- paste(tmpdir, "UCI HAR Dataset/test/X_test.txt", sep="/")
X_train_dat_file          <- paste(tmpdir, "UCI HAR Dataset/train/X_train.txt", sep="/")

# y labels
Y_test_labels_file        <- paste(tmpdir, "UCI HAR Dataset/test/y_test.txt", sep="/")
Y_train_labels_file       <- paste(tmpdir, "UCI HAR Dataset/train/y_train.txt", sep="/")

# subject labels
subject_test_labels_file  <- paste(tmpdir, "UCI HAR Dataset/test/subject_test.txt", sep="/")
subject_train_labels_file <- paste(tmpdir, "UCI HAR Dataset/train/subject_train.txt", sep="/")

# activity labels
activity_labels_file      <- paste(tmpdir, "UCI HAR Dataset/activity_labels.txt", sep="/")

# features
features_file             <- paste(tmpdir, "UCI HAR Dataset/features.txt", sep="/")

# read the data in

X_test_dat           <- read.table(X_test_dat_file)
X_train_dat          <- read.table(X_train_dat_file)
Y_test_labels        <- read.table(Y_test_labels_file,        col.names="ActivityID")
Y_train_labels       <- read.table(Y_train_labels_file,       col.names="ActivityID")
subject_test_labels  <- read.table(subject_test_labels_file,  col.names="Subject")
subject_train_labels <- read.table(subject_train_labels_file, col.names="Subject")
activity_labels      <- read.table(activity_labels_file,      col.names=c("ActivityID", "Activity"))
features             <- read.table(features_file,             col.names=c("FeatureID", "Feature"))

# 4 Appropriately labels the data set with descriptive variable names. 
# name the dat with the features.  These are descriptive enough - no need to make them more wordy.
colnames(X_test_dat) <- as.vector(features[,2])
colnames(X_train_dat) <- as.vector(features[,2])

# cbind the subject and the activity ID with the data
testDat <- cbind(subject_test_labels, Y_test_labels, X_test_dat)
trainDat <- cbind(subject_train_labels, Y_train_labels, X_train_dat)

# 3 Uses descriptive activity names to name the activities in the data set
# merge in the ActivityID
testDat <- merge(activity_labels,testDat)
trainDat <- merge(activity_labels,trainDat)

# 1 Merges the training and the test sets to create one data set.
# rbind this into one data set
allDat <- rbind(testDat,trainDat)

# Locate the columns for mean and std.  Make sure to miss out meanFreq
meanStdCols <- grep("mean\\(|std\\(",names(allDat)) 

# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
# generate the final data set
meanStdDat <- allDat[c(1,2,3,meanStdCols)]

# 5 From the data set create a second, independent tidy data set with the average of each variable for each activity and each subject.
# flatten the data by subject and activity
meltedMeanStdDat <- melt(meanStdDat, id=c("Subject", "ActivityID", "Activity"))

# pivot the data and calculate mean
castMeanStdDat <- dcast(meltedMeanStdDat, Subject + ActivityID + Activity ~ variable, mean)

# write out the new data file
write.table(castMeanStdDat, "castMeanStdDat.txt", row.name=FALSE, sep=",")
