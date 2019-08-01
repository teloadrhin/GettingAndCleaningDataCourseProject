# Code book

## Data source 
The data used for this project are based on the [Human Activity Recognition Using
Smartphones
Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)<sup>[1](#Footnote1)</sup>
and were downloaded from
[here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

The [README.txt](txt_files/README.txt) file in the ZIP-archive gives a brief description of the data: 

> The experiments have been carried out with a group of 30 volunteers within an age bracket
> of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS,
> WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II)
> on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear
> acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have
> been video-recorded to label the data manually. The obtained dataset has been randomly
> partitioned into two sets, where 70% of the volunteers was selected for generating the
> training data and 30% the test data.
>
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise
> filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128
> readings/window). The sensor acceleration signal, which has gravitational and body motion
> components, was separated using a Butterworth low-pass filter into body acceleration and
> gravity. The gravitational force is assumed to have only low frequency components,
> therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of
> features was obtained by calculating variables from the time and frequency domain. 
> ...

More details are given in the file [features_info.txt](txt_files/features_info.txt): 

> The features selected for this database come from the accelerometer and gyroscope 3-axial
> raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time)
> were captured at a constant rate of 50 Hz. Then they were filtered using a median filter
> and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove
> noise. Similarly, the acceleration signal was then separated into body and gravity
> acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth
> filter with a corner frequency of 0.3 Hz.
>
> Subsequently, the body linear acceleration and angular velocity were derived in time to
> obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these
> three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag,
> tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).
>
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing
> fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag,
> fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).
>
> These signals were used to estimate variables of the feature vector for each pattern:  
> '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.
>
> tBodyAcc-XYZ  
> tGravityAcc-XYZ  
> tBodyAccJerk-XYZ  
> tBodyGyro-XYZ  
> tBodyGyroJerk-XYZ  
> tBodyAccMag  
> tGravityAccMag  
> tBodyAccJerkMag  
> tBodyGyroMag  
> tBodyGyroJerkMag  
> fBodyAcc-XYZ  
> fBodyAccJerk-XYZ  
> fBodyGyro-XYZ  
> fBodyAccMag  
> fBodyAccJerkMag  
> fBodyGyroMag  
> fBodyGyroJerkMag  
>
> The set of variables that were estimated from these signals are: 
>
> mean(): Mean value  
> std(): Standard deviation  
> mad(): Median absolute deviation   
> max(): Largest value in array  
> min(): Smallest value in array  
> sma(): Signal magnitude area  
> energy(): Energy measure. Sum of the squares divided by the number of values.   
> iqr(): Interquartile range   
> entropy(): Signal entropy  
> arCoeff(): Autorregresion coefficients with Burg order equal to 4  
> correlation(): correlation coefficient between two signals  
> maxInds(): index of the frequency component with largest magnitude  
> meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
> skewness(): skewness of the frequency domain signal   
> kurtosis(): kurtosis of the frequency domain signal   
> bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each
> window.  
> angle(): Angle between to vectors.  
>
> Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
>
> gravityMean  
> tBodyAccMean  
> tBodyAccJerkMean  
> tBodyGyroMean  
> tBodyGyroJerkMean  

## Data analysis 
This section gives a brief description of how the data analysis is done in the [R
script](run_analysis.R).

### Merge the training and the test sets to create one data set
The [README.txt](txt_files/README.txt) file tells us where to find the training and test data sets and the
corresponding labels: 

> ...  
>   
> - 'train/X_train.txt': Training set.  
>
> - 'train/y_train.txt': Training labels.  
>
> - 'test/X_test.txt': Test set.  
>
> - 'test/y_test.txt': Test labels.  
>  
>...  

The data provided in the *Inertial Signals* subfolders is not relevant for the assignment
and is ignored by the data analysis script. 

For details on how the data is imported please refer to the comments in
[run_analysis.R](run_analysis.R). 

Since the columns in the test and training data sets correspond to the same observables it
is straight forward to merge the two data sets with `rbind`.   

### Extract only the measurements on the mean and standard deviation for each measurement
This task is actually not well defined and there is some room for interpretation. In any
case it is necessary to have a look at the feature names, provided in the file
[features.txt](txt_files/features.txt): 

> 1 tBodyAcc-mean()-X  
> 2 tBodyAcc-mean()-Y  
> 3 tBodyAcc-mean()-Z  
> 4 tBodyAcc-std()-X  
> 5 tBodyAcc-std()-Y  
> 6 tBodyAcc-std()-Z  
> 7 tBodyAcc-mad()-X  
> 8 tBodyAcc-mad()-Y  
> 9 tBodyAcc-mad()-Z  
> 10 tBodyAcc-max()-X  
> 11 tBodyAcc-max()-Y  
> 12 tBodyAcc-max()-Z  
> 13 tBodyAcc-min()-X  
> 14 tBodyAcc-min()-Y  
> 15 tBodyAcc-min()-Z  
> 16 tBodyAcc-sma()  
> 17 tBodyAcc-energy()-X  
> 18 tBodyAcc-energy()-Y  
> 19 tBodyAcc-energy()-Z  
> 20 tBodyAcc-iqr()-X  
> 21 tBodyAcc-iqr()-Y  
> 22 tBodyAcc-iqr()-Z  
> 23 tBodyAcc-entropy()-X  
> 24 tBodyAcc-entropy()-Y  
> 25 tBodyAcc-entropy()-Z  
> 26 tBodyAcc-arCoeff()-X,1  
> 27 tBodyAcc-arCoeff()-X,2  
> 28 tBodyAcc-arCoeff()-X,3  
> 29 tBodyAcc-arCoeff()-X,4  
> 30 tBodyAcc-arCoeff()-Y,1  
> 31 tBodyAcc-arCoeff()-Y,2  
> 32 tBodyAcc-arCoeff()-Y,3  
> 33 tBodyAcc-arCoeff()-Y,4  
> 34 tBodyAcc-arCoeff()-Z,1  
> 35 tBodyAcc-arCoeff()-Z,2  
> 36 tBodyAcc-arCoeff()-Z,3  
> 37 tBodyAcc-arCoeff()-Z,4  
> 38 tBodyAcc-correlation()-X,Y  
> 39 tBodyAcc-correlation()-X,Z  
> 40 tBodyAcc-correlation()-Y,Z  
> ...  
> ...  
> ...  
> 294 fBodyAcc-meanFreq()-X  
> 295 fBodyAcc-meanFreq()-Y  
> 296 fBodyAcc-meanFreq()-Z  
> ...  
> ...  
> ...  
> 555 angle(tBodyAccMean,gravity)  
> 556 angle(tBodyAccJerkMean),gravityMean)  
> 557 angle(tBodyGyroMean,gravityMean)  
> 558 angle(tBodyGyroJerkMean,gravityMean)  
> 559 angle(X,gravityMean)  
> 560 angle(Y,gravityMean)  
> 561 angle(Z,gravityMean)  

As we can see, the standard deviation and the mean of measurements are have the strings
"std()" and "mean()" as part of their names. However, there are also other features related
in some way to a mean, which have the strings "meanFreq()" and "Mean" as part of their
names. 
 

The meaning of this names can be deduced from the description in the [features_info.txt](txt_files/features_info.txt)
file (see [above](#data-source)). 
"Mean" only appears as part of angle features, which measure the angle between two
vectors. This feature can not be interpreted simply as the mean of an measurement.
"meanFreq" indicates a weighted average of the frequency components and is also not a
simple mean of an observation. 


Therefore, only features with names that include the strings "std()" and "mean()" are
extracted by the analysis script. 


### Uses descriptive activity names to name the activities in the data set
The file activity_labels.txt contains descriptive names for the numerical activity
labels. The analysis script reads the names from this file and substitutes the numerical
labels in the activity column of the data set with the corresponding name. 

See the [source code](run_analysis.R) for details. 

### Appropriately label the data set with descriptive variable names
As mentioned above, the names of the features are available and can be read in from the
file [features.txt](txt_files/features.txt). 
For better readability the following changes are made to the feature names

>  * "()" -> removed  
>  * " " -> "."  
>  * "-" -> "."  
>    
>  * Acc ->  Accelerometer  
>  * Gyro -> Gyroscope  
>  * Mag  -> Magnitude  
 
The columns are then labeled with the corresponding feature name. 
The column with the person identification is labeled "PersonID" and the activity column
"Activity". 

### From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
With the help of the functions `group_by` and `summarise_all` from the *dplyr* package it
is straight forward to group the data set by "PersonID" and "Activity" and compute the
mean over the groups. 

To clearly indicate that the group mean has been taken for the features, the string
"GroupMean." is added in front of the column names of the feature columns. 


Finally, the data set is written to a file using 
``` R
write.table(res,"./result.dat",row.name=FALSE) 
```

## Description of the data in file produced by the analysis script 

The data set contains the results of an experiment with a group of 30 people. Each person
performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
STANDING, LAYING) while wearing a smartphone (Samsung Galaxy S II) on the waist. Using the
smartphone's gyroscope and accelerometer 3-axial linear acceleration and 3-axial angular
velocity were measured at a constant rate of 50Hz. 

The sensor signals were pre-processed and a set of features were computed, see
[README.txt](txt_files/README.txt) and [features_info.txt](txt_files/features_info.txt)
for details. For this data set only the features related to the measurements on the mean
and standard deviation for each measurement were taken into account. For these features
the mean over the groups for given person id and activity was taken. The final result is
stored in a text file. The first column in the file contains the person id, the second
column the name of the activity and the following columns the mean of the features.

The feature column names have the general form "GroupMean.<FeatureName>". The explanation
of the <FeatureName> can be found in the file
[features_info.txt](txt_files/features_info.txt) of the original data set. 


---

<a name="Footnote1">[1]</a>: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
