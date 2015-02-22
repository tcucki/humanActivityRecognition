TidyData.txt Code Book
===========

This file describes the data in "TidyData.txt" file

The grouping fields are the following:  

* Subject: type numeric, length = 1..2  
    + Description: Subject number who performed the activity  
        + 1..30   Unique identifier signed to a subject  
        
* ActivityName: type character, length = 6..18
    + Description: The activity performed
        + WALKING
        + WALKING_UPSTAIRS
        + WALKING_DOWNSTAIRS
        + SITTING
        + STANDING
        + LAYING

The remaining fields are the average of the measurements mean and standard deviation, as follows:    

* prefix 't': denotes time
* prefix 'f': denotes frequency domain signals
* sufix .mean.*: the average of a Mean value
* sufix .std.*: the average of a standard deviation vaue
* sufix .X, .Y or .Z: a measurement to a specific axis (X, Y or Z)

All the average values are type numeric with precision of 18 digits and scale of 17 digits. Theses average values are the following:

tBodyAcc.mean.X  
tBodyAcc.mean.Y  
tBodyAcc.mean.Z  
tBodyAcc.std.X  
tBodyAcc.std.Y  
tBodyAcc.std.Z  
tGravityAcc.mean.X  
tGravityAcc.mean.Y  
tGravityAcc.mean.Z  
tGravityAcc.std.X  
tGravityAcc.std.Y  
tGravityAcc.std.Z  
tBodyAccJerk.mean.X  
tBodyAccJerk.mean.Y  
tBodyAccJerk.mean.Z  
tBodyAccJerk.std.X  
tBodyAccJerk.std.Y  
tBodyAccJerk.std.Z  
tBodyGyro.mean.X  
tBodyGyro.mean.Y  
tBodyGyro.mean.Z  
tBodyGyro.std.X  
tBodyGyro.std.Y  
tBodyGyro.std.Z  
tBodyGyroJerk.mean.X  
tBodyGyroJerk.mean.Y  
tBodyGyroJerk.mean.Z  
tBodyGyroJerk.std.X  
tBodyGyroJerk.std.Y  
tBodyGyroJerk.std.Z  
tBodyAccMag.mean  
tBodyAccMag.std  
tGravityAccMag.mean  
tGravityAccMag.std  
tBodyAccJerkMag.mean  
tBodyAccJerkMag.std  
tBodyGyroMag.mean  
tBodyGyroMag.std  
tBodyGyroJerkMag.mean  
tBodyGyroJerkMag.std  
fBodyAcc.mean.X  
fBodyAcc.mean.Y  
fBodyAcc.mean.Z  
fBodyAcc.std.X  
fBodyAcc.std.Y  
fBodyAcc.std.Z  
fBodyAcc.meanFreq.X  
fBodyAcc.meanFreq.Y  
fBodyAcc.meanFreq.Z  
fBodyAccJerk.mean.X  
fBodyAccJerk.mean.Y  
fBodyAccJerk.mean.Z  
fBodyAccJerk.std.X  
fBodyAccJerk.std.Y  
fBodyAccJerk.std.Z  
fBodyAccJerk.meanFreq.X  
fBodyAccJerk.meanFreq.Y  
fBodyAccJerk.meanFreq.Z  
fBodyGyro.mean.X  
fBodyGyro.mean.Y  
fBodyGyro.mean.Z  
fBodyGyro.std.X  
fBodyGyro.std.Y  
fBodyGyro.std.Z  
fBodyGyro.meanFreq.X  
fBodyGyro.meanFreq.Y  
fBodyGyro.meanFreq.Z  
fBodyAccMag.mean  
fBodyAccMag.std  
fBodyAccMag.meanFreq  
fBodyBodyAccJerkMag.mean  
fBodyBodyAccJerkMag.std  
fBodyBodyAccJerkMag.meanFreq  
fBodyBodyGyroMag.mean  
fBodyBodyGyroMag.std  
fBodyBodyGyroMag.meanFreq  
fBodyBodyGyroJerkMag.mean  
fBodyBodyGyroJerkMag.std  
fBodyBodyGyroJerkMag.meanFreq  