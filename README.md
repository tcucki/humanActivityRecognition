Analysis files explained
===========

This file describes the scripts contained in file **run_analysis.R**.

The goal of this script is to prepare tidy data from "Human Activity Recognition Using Smartphones Data Set" project. The tidy data is written into disk with name **TidyData.txt** in comma separated values format.

To read the tidy data from disk, in R the following code should be executed: **read.csv("TidyData.txt")** in the directory where the tidy file was written.

To learn about data in TidyData.txt, check the **CodeBook.md** file.

##Running the script
* Main function: **runAnalysis** - It is the function to be executed. This function has no required parameters, except to parameter **downloadMethod** which defaults to "auto" and must have the value "curl" to work on UNIX based systems.

Otherwise, the original file must be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and has to be named **dataset.zip**, on "project" folder under working directory.

###Optional parameters
* **maxRows**: Number of rows to read from training and test data sets. Defaults to -1, indicating all rows must be read. Otherwise maxRows rows from theses data sets will be read.
* **folder**: a directory under the current working directory where downloaded and created data will be persisted. Defaults to "project".
* **downloadMethod**: The method to download the original .zip file. Defaults to "auto". On UNIX based systems this parameter has to be "curl"

##Subfunctions
* **loadSourceData**: Downloads data from the web if the project folder doesn't contain it, creating required directories if necessary
* **loadFeatureLabels**: Loads feature labels from "features.txt" file
* **loadTrainingData**: Loads training data, applying column names read from loadFeatureLabels and activity indexes from y_train.txt, and merging subjects who performed the activity for each window sample, from file "subject_train.txt".
* **loadTestData**: Loads test data, applying column names read from loadFeatureLabels and activity indexes from y_test.txt, and merging subjects who performed the activity for each window sample, from file "subject_test.txt".
* **mergeData**: Appends test data into training data
* **extractMeasurements**: Returns a new data frame discarding no required columns. The required columns are mean and standard deviation measurements, plus subject and activity index
* **mergeActivity**: Adds descriptive activity names into data
* **summarize**: Calculates averages for each variable for each activity and each subject
* **renameColumnNames**: Removes the "..." in the column names, duo to dots and parenthesis in original column names
* **saveData**: Persists tidy data into disk

##The script
The following steps are taken in script's execution:

1. Download source data
    + 1.1. Create container folder if it doesn't exists
    + 1.2. Download original data set if it doesn't exists
    + 1.3 Unzip data (always unzip data to make sure it's original source data set)
2. Load features labels
3. Setup columns widths to read training and test data, which are 561 columns with length of 16 each
4. Load training data
    + 4.1. Read data in fixed width format
    + 4.2. Read the activity index for each row
    + 4.3. Merge activity index into data set
    + 4.4. Read subjects who executed activity for each row
    + 4.5. Merge subjects into data set
5. Load test data
    + 5.1. Read data in fixed width format
    + 5.2. Read the activity index for each row
    + 5.3. Merge activity index into data set
    + 5.4. Read subjects who executed activity for each row
    + 5.5. Merge subjects into data set
6. Append test data set into training data set
7. Extract only required columns (mean and standard deviation measurements, and activity and subject)
8. Add descriptive activity names into data
9. Create a new data set with the averages for each variable/measurement for each activity and each subject
10. Rename column names, removing ".." from column names duo to dots and parenthesis in original column names
11. Persist data into disk, in comma separated values format