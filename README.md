# GettingAndCleaningDataCourseProject
Final project for the "Getting and Cleaning Data" course on coursera.org

## Data source
The data for this assignment is taken from the UCI Machine Learning Repository. For a
description of the dataset see
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Assignment instructions
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set.
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the
average of each variable for each activity and each subject.


## Data analysis script 
The R script [run_analysis.R](run_analysis.R) looks for a file named *UCI HAR Dataset.zip*
in the working directory. If the file is not found the script tries to download the data. 

Details about the data analysis are described in the [code book](CodeBook.md) file. 

The final result of the script is a tidy data set, which is written to a file named
*result.dat* in the working directory. 
