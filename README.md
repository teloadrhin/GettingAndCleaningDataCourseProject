# GettingAndCleaningDataCourseProject
Final project for the "Getting and Cleaning Data" course on coursera.org

## Data source
The data for this assignment is taken from the UCI Machine Learning Repository. For a
description of the data set see
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## Assignment instructions
1. Merge the training and the test sets to create one data set.
2. Extract only the measurements on the mean and standard deviation for each measurement.
3. Use descriptive activity names to name the activities in the data set.
4. Appropriately label the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the
average of each variable for each activity and each subject.


## Data analysis script 

* The R script [run_analysis.R](run_analysis.R) looks for a file named *UCI HAR
  Dataset.zip* in the working directory. If the file is not found the script tries to
  download the data.
  
* The script then reads and merges the test and train data set

* From the merged data set only measurements on the mean and standard deviation are kept  

  **IMPORTANT NOTE: The assignment instructions on this point are not clear and up to
  interpretation. Please check the explanation of which measurements were included and why
  in the code book. When grading my work, please do not deduct points simply because you
  made a different choice**
  
* The activity names can be found in a text file accompanying the original data set. The
  script reads the names and substitutes the numerical activity id by its name.

* The labels for the data set are also supplied in a text file. The script reads the
  names, makes them more explicit and human readable, and adds the labels to the data set.

* Finally, the mean over the groups described in point 5 of the assignment is taken and
  the result is written to a file named *result.dat* in the working directory.


More details about the script and the data analysis can be found in the [code book](CodeBook.md) file.



