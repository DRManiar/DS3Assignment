#
# Load data.table and dplyr packages
#
library(data.table)
library(dplyr)
#
# Reading the common data:
#
# features.txt contains the column variable names
features<-read.table("../../UCI HAR Dataset/features.txt",header = FALSE,sep = " ")
#
# Find the column positions with either "mean" or "std" in the variable name
channels<-grep("mean|std",features[,2])
#
# activity_labels.txt contains activity labels
activity<-read.table("../../UCI HAR Dataset/activity_labels.txt")
#
# Setting widths vector to read in fixed-format files
wids<-rep(16,nrow(features))
#
# Read the training database
#
# Reading training data measurements using fixed-format
xtrain<-read.fwf("../../UCI HAR Dataset/train/X_train.txt",
                 widths = wids, header = FALSE, sep = "")
#
# Reading vector of training subject
subtrain<-read.table("../../UCI HAR Dataset/train/subject_train.txt",
                     header = FALSE,sep = " ")
#
# Reading the training activity data
ytrain<-read.table("../../UCI HAR Dataset/train/y_train.txt",
                   header = FALSE,sep = " ")
#
# Naming the training subject data
names(subtrain)<-"subject"
#
# Setting training subject data as data.table to be able to mutate
subtrain<-as.data.table(subtrain)
#
# Mutate the training subject to add activity labels as 2nd column
subtrain[,activity:=activity[ytrain[[1]],2]]
#
# Read the test database
#
# Reading test data measurements using fixed-format
xtest<-read.fwf("../../UCI HAR Dataset/test/X_test.txt",
                widths = wids, header = FALSE, sep = "")
#
# Reading vector of test subject
subtest<-read.table("../../UCI HAR Dataset/test/subject_test.txt",
                    header = FALSE,sep = " ")
#
# Reading the test activity data
ytest<-read.table("../../UCI HAR Dataset/test/y_test.txt",
                  header = FALSE,sep = " ")
#
# Naming the test subject data
names(subtest)<-"subject"
#
# Setting test subject data as data.table to be able to mutate
subtest<-as.data.table(subtest)
#
# Mutate the test subject to add activity lables as 2nd column
subtest[,activity:=activity[ytest[[1]],2]]
#
# Combine training and test databases
#
# Combine rows of the two datasets: training and test
subact<-rbind(subtrain,subtest) # First 2 columns
alldata<-rbind(xtrain,xtest) 	# Rest of the columns
#
# Select measurements columns for the selected channels
alldata.f<-select(alldata,all_of(channels))
#
# Name columns for all measurements
names(alldata)<-features[,2]
#
# Name selected columns
names(alldata.f)<-features[channels,2]
#
# Combine subject and activity columns with all measurements
alldata<-cbind(subact,alldata)
#
# Combine subject and activity columns with selected columns
alldata.f<-cbind(subact,alldata.f)
#
# Estimate average of mean and std measurements by subject and activity 
#
# Create subject column as factor
by1<-factor(alldata.f$subject)
#
# Create activity column as factor
by2<-factor(alldata.f$activity)
#
# Aggregate average of mean and std measurements by subject and activity
meantbl<-aggregate(alldata.f[,3:ncol(alldata.f)],
                   by=list(subject=by1,activity=by2),FUN=mean)
#
# Write out meantbl = "mean table" to a file
write.table(meantbl,file = "./DS3Assign_tidytable.txt",row.names = FALSE)
