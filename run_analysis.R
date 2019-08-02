################################################################################
## Init
################################################################################

## Get clean workspace 
rm(list=ls())

## Load libs
library(dplyr)  ## for summarise, group_by


################################################################################
## Get data
################################################################################

my_zip <- "./UCI HAR Dataset.zip"
if (!file.exists(my_zip)){
    my_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    print("Downloading zip archive ..." )
    download.file(my_url,my_zip,method="curl")
    print("... DONE!")
}

################################################################################
## Look at zip file
################################################################################
unzip(my_zip,list=TRUE)


################################################################################
## Read data
################################################################################

## variables to hold directory and file names 
traindir <- file.path("UCI HAR Dataset","train")
testdir <- file.path("UCI HAR Dataset","test")
trainstr <- "_train.txt"
teststr <-  "_test.txt"

## helper function to read data from zipped archive
##    - obs:     string ("subject", "X" or "y")
##    - train:   bool (TRUE for training data, FALSE for test data)
##    - classes: vector defining the classes of the columns in the data file 
my_read  <- function(obs,train=TRUE,classes = c("numeric")){

    read_dir <- traindir
    read_str <- trainstr

    if (!train){
        read_dir <- testdir
        read_str <- teststr
    }

    print(paste("Reading file ",file.path(read_dir,paste0(obs, read_str))))
    
    read.table(unz(my_zip,
                   file.path(read_dir,paste0(obs, read_str))),
               colClasses = classes)
}

## helper function to read the feature names 
get_feature_names <- function(feat_str="features.txt", feat_dir="UCI HAR Dataset"){
     my_feat <- read.table(unz(my_zip,
                               file.path(feat_dir,feat_str)),
                           stringsAsFactors = FALSE)
     my_feat[,2]
}

## helper functions to read the activity labels 
get_activity_labels <- function(act_str="activity_labels.txt", act_dir="UCI HAR Dataset"){
     my_act <- read.table(unz(my_zip,
                               file.path(act_dir,act_str)),
                          colClasses=c("character"),
                          col.names = c("act_id","activity"))
     my_act
}

## helper function to read in all the data for train or
## test data set, respectively
##     - train_flag: bool (true for training data)
my_import <- function(train_flag=TRUE){

    my_df <- my_read("subject",train_flag,"character")
    my_df <- cbind(my_df,my_read("y",train_flag,"character"))
    my_df <- cbind(my_df,my_read("X",train_flag,"numeric"))

}


## Read data sets

## Note: Raw data from the 'Inertial Signals' subfolders is not read,
## since the focus here is on the features extracted from the raw
## data, i.e., the Training data set and the Test data set.

train_df_raw <- my_import(TRUE)
test_df_raw <- my_import(FALSE)


################################################################################
## Merge and tidy up data
################################################################################

## Step 1: Merging

## Since the meaning of the columns is the same in both data sets we can
## simply put them togehter with rbind
df_raw <- rbind(train_df_raw,test_df_raw)

## A simple consistency check
#dim(df_raw)[1] == dim(test_df_raw)[1] + dim(train_df_raw)[1]

## Step 2: Extract only the measurements on the mean and standard
## deviation for each measurement

## Note: This is somewhat open for interpretation. In the
## "features_info.txt" it is mentioned that additionally to the
## variables estimated from the signals directly - such as mean, std,
## max, min, etc. - there are also additional vectors which are used
## to calculate the angle(..,..) features and also depend on means. I
## did not include any angle features in the final tidy data set,
## since they are not simply the mean/std of a measured variable.
## Moreover, I also left out the *meanFreq()* features. 

## First name the feature columns in the raw data set to make them easier to work with
names(df_raw)[3:length(names(df_raw))] = get_feature_names()

## Extract only features with 'mean()' and 'std()' in the name
## (Also keep ID and activity columns of course)
df_raw  <-  df_raw[,c(1,2,grep("mean\\(\\)|std\\(\\)",names(df_raw)))]

## Step 3: Uses descriptive activity names to name the activities in the data set
## Replacing number labels for activities with the activity name
ac  <-  get_activity_labels()
for (i in 1:length(ac$act_id)){
    df_raw[,2] <- sub(ac$act_id[i],ac$activity[i],df_raw[,2])
}


## Step 4: Appropriately labels the data set with descriptive variable names
## Adding labels

## Person Id and Activity are straight forward ...
names(df_raw)[1:2]=c("PersonID","Activity")

## ... the rest not so much. We do some clean up
##
##     "()" -> removed
##     " " -> "."
##     "-" -> "."
##
## and replace
##
##     Acc ->  Accelerometer 
##     Gyro -> Gyroscope
##     Mag  -> Magnitude
##     t at the beginning of a name -> Time
##     f at the beginning of a name -> Frequency 
nms <- sub("\\(\\)","",names(df_raw))
nms <- make.names(nms)
nms <- sub("Mag","Magnitude",nms)
nms <- sub("Acc","Accelerometer",nms)
nms <- sub("Gyro","Gyroscope",nms)
nms <- sub("^t","Time.",nms)
nms <- sub("^f","Frequency.",nms)

names(df_raw) <- nms 

## Step 5: average of each variable for each activity and each subject

gp <- group_by(df_raw,PersonID,Activity)
res <- as.data.frame(summarise_all(gp,mean))

## Tidy names
for (i in 3:length(names(res))){
    names(res)[i] <- names(res)[i]
}

## Write dataset to file
write.table(res,"./result.dat",row.name=FALSE) 

