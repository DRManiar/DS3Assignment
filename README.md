# DS3Assignment
title: "Data Science Course 3 (Getting and Cleaning Data) Assignment"
author: "DRManiar"
date: "6/4/2020"

# Tidy Data Description

The tidy data obtained after Step 4 is written out as "DS3Assign_tidytable.txt". The data dimension is 180 rows and 81 columns. The columns are decribed below.

* Column 1 - Contains subject data as number. There are 30 subjects with a range of 1 to 30.
* Column 2 - Contains activity data as characters. There are six activities.
* Columns 3-81 - Contains average values of either mean or standard devitation of measurements and the average values are grouped by each subject and activity. The columns are named using the variable names from features.txt. Since there are 30 subjects and six activities; there are 180 row (30x6).

Each row the table contains one measurment, and each column contains one variable. The column names are unique and they are human readble (see CodeBook.txt which defines each variable) and meets the requirements of a tidy data.

# Raw Data Manupulation to Obtain the Tidy Data

The data.table and dplyr packages are used, so they need to be loaded first.

 * Step 1: Read features.txt containing all variable names using read.table().
 * Step 2: Selected column variables that contains either "mean" or "std" using grep() function. This will be used later to select the data columns once the datasets are merged together.
 * Step 3: Read activity_labels.txt containing activity data using read.table().
 * Step 4: Read measurements from the training data set using fixed-wdith format.
 * Step 5: Read subject_train.txt and y_train.txt data.
 * Step 6: Combined the subject and activity columns for training data set such that the activity column contains activity label rather than numeric keys.
 * Step 7: Repeated Steps 4, 5, and 6 for the test data set.
 * Step 8: Combined rows the training and test data sets.
 * Step 9: Created a subset of the data using the "channels" vector created using grep() function in Step 2. This produced the data with 79 columns.
 * Step 10: Assigned appropriate variable name to each columns of the merged raw data and subset of the data. Note: Naming variable before selecting columns was creating an error message due to a few duplicate variable name in the features.txt. However, those columns are not selected for the tidy data, so naming them after the fact avoided the error message.
 * Step 11: Combined first two columns (subject and activity) with the raw data as well as the data with selected 79 columns.
 * Step 12: For the selected data, created factor data for subject and activity.
 * Step 13: Using aggregate() function, avearge values of mean and standard devitation columns are calculated by each subject and each activity. The resulting tidy data (and required) is stored in "meantbl" table.
 * Step 14: The "meantbl" table is written out as DS3Assign_tidytable.txt.
 
 
