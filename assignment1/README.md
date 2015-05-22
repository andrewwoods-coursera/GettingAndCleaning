Notes for Getting and Cleaning Data assignment
===========

R version 3.1.1 (2014-07-10) -- "Sock it to Me"
Copyright (C) 2014 The R Foundation for Statistical Computing
Platform: x86_64-pc-linux-gnu (64-bit)

linux kernel version 3.16

Additional OS software required:  curl
Additional R packages required: data.table, reshape2

The code uses:
'''
tempfile        package:base
tempdir         package:base
paste           package:base
colnames        package:base
cbind           package:base
rbind           package:base
grep            package:base
download.file   package:utils
unzip           package:utils
read.table      package:utils
write.table     package:utils 
merge           package:data.table
melt            package:reshape2
dcast           package:reshape2
'''

The code assumes the structure of the data zip file is known.  The file run_analysis.R is well commented, but to summarise it's operaion:

1. load the libraries data.table and reshape2
2. create a tempdir() which works on all platforms with a platform-dependent result
3. create a tempfile()
4. download the data to the tempfile and then extract it into the tempdir
5. identify the files we are interested in
6. read.tabel the files we are interested in
7. the provided features are descriptive variable names, use these as the column names for the test and train data
8. cbind the activityID and subjectID with the test and train data
9. merge in the Activity names into the two data sets
10. merge the test and train data sets together

We now have a complete data set with descriptive labels

We are interested in generating a table of only the means and standard deviation, so:

1. locate the position of the mean and standard deviation values in the names of the data set using grep.
2. subset the data
3. flatten the data by "Subject", "ActivityID", "Activity"
4. re-pivot the data to sow the average mean and the average stadard deviation by subject and activity.
5. write the table out

The produced table gives the subject, activityID, activity and the average value for each of the variables in the heading.

To run this code, simply:
'''
source("run_analysis.R")
'''
The code will download and extract the zip, merge and subset the data and write out the file "castMeanStdDat.txt"
 
