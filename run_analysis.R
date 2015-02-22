# R script for the Getting and Cleaning Data course project

runAnalysis <- function(maxRows = -1, folder = "project", downloadMethod = "auto") {
    
    # setup constants
    destFile <- paste(folder, "/dataset.zip", sep = "")
    sourceDatasetDir <- paste(folder, "/UCI HAR Dataset", sep = "")
    mainColsExpression <- "mean|std"
    
    #####
    # loads source data if project folder doesn't contain it
    # NOTE: uses downloadMethod to determine the method to download file
    # always extract/unzip files to make sure that's original in source dataset folder
    ####
    loadSourceData <- function() {
        
        if (!file.exists(folder)) {
            message("creating folder...")
            dir.create(folder)
        }
        if (!file.exists(destFile)) {
            message("downloading source dataset")
            sourceURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
            download.file(sourceURL, destFile, method = downloadMethod)
        }
        message("unziping source dataset")
        unzip(zipfile = destFile, exdir = folder)
    }
    
    # load feature labels from "features.txt" file
    loadFeatureLabels <- function() {
        message("loading features")
        fileName <- paste(sourceDatasetDir, "/features.txt", sep = "")
        fts <- read.csv(fileName, sep = " ", header = FALSE)
        as.character(fts[,2])
    }

    ##
    # load training data
    # colLabels = label of each column
    # cws = widths of each column
    # returns training dataset with feature index
    ##
    loadTrainingData <- function(colLabels, cws) {

        message("loading training dataset")
        trainFileName <- paste(sourceDatasetDir, "/train/X_train.txt", sep = "")
        xtrain <- read.fwf(trainFileName, widths = cws, col.names = colLabels, header = FALSE, n = maxRows)

        message("loading training labels indexes")
        trainLabelFileName <- paste(sourceDatasetDir, "/train/y_train.txt", sep = "")
        labels <- read.table(trainLabelFileName, header = FALSE, nrows = maxRows)

        message("mergind labels indexes into training dataset")
        xtrain$labelIndex <- labels[,1]
        
        message("loading subjects")
        trainSubjectFileName <- paste(sourceDatasetDir, "/train/subject_train.txt", sep = "")
        labels <- read.table(trainSubjectFileName, header = FALSE, nrows = maxRows)
        
        message("mergind subjects into training dataset")
        xtrain$subject <- labels[,1]
        
        message("training dataset loaded ", nrow(xtrain), " X ", ncol(xtrain))
        xtrain
    }

    ##
    # load test data
    # colLabels = label of each column
    # cws = widths of each column
    # returns test dataset with feature index
    ##
    loadTestData <- function(colLabels, cws) {
        
        message("loading test dataset")
        testFileName <- paste(sourceDatasetDir, "/test/X_test.txt", sep = "")
        xtest <- read.fwf(testFileName, widths = cws, col.names = colLabels, header = FALSE, n = maxRows)
        
        message("loading test labels indexes")
        testLabelFileName <- paste(sourceDatasetDir, "/test/y_test.txt", sep = "")
        labels <- read.table(testLabelFileName, header = FALSE, nrows = maxRows)
        
        message("mergind labels indexes into test dataset")
        xtest$labelIndex <- labels[,1]
        
        message("loading subjects")
        testSubjectFileName <- paste(sourceDatasetDir, "/test/subject_test.txt", sep = "")
        labels <- read.table(testSubjectFileName, header = FALSE, nrows = maxRows)
        
        message("mergind subjects into test dataset")
        xtest$subject <- labels[,1]
        
        message("test dataset loaded ", nrow(xtest), " X ", ncol(xtest))
        xtest
    }

    ##
    # returns a new data frame from trainingData appended with testData
    ##
    mergeData <- function(trainingData, testData) {
        
        message("appending test dataset into training dataset")
        data <- rbind(trainingData, testData)
        message("appended into ", nrow(data), " X ", ncol(data))
        data
    }
    
    ##
    # extract the mean and standard deviation measurements
    ##
    extractMeasurements <- function(data) {
      
        message("extracting mean and standard deviation measurements")
        # retrieve only "mean" and "std" column indexes
        cn <- colnames(data)
        cols <- grep(mainColsExpression, cn)
        # add last two columns (labels indexes and subjects)
        cols <- append(cols, c(ncol(data) -1, ncol(data)))
        clean <- data[,cols]
        message("data extracted into ", nrow(clean), " X ", ncol(clean))
        clean
    }
    
    ##
    # Add descriptive activity names into data
    ##
    mergeActivity <- function(data) {

        message("Adding descriptive activity names into data")
        fileName <- paste(sourceDatasetDir, "/activity_labels.txt", sep = "")
        activities <- read.fwf(fileName, widths = c(2, 30), header = FALSE, col.names = c("id", "ActivityName"))
        
        data <- merge(data, activities, by.x = "labelIndex", by.y = "id")
        message("Merged activities to dataset: ", nrow(data), " X ", ncol(data))
        data
    }
    
    ##
    # Calculate averages for each variable for each activity and each subject
    ##
    summarize <- function(data) {
        
        message("Summarizing data")
        # retrieve only "mean" and "std" column indexes
        cn <- colnames(data)
        cols <- grep(mainColsExpression, cn)
        
        data <- aggregate(data[,cols], list(Subject = data$subject, ActivityName = data$ActivityName), mean)
        
        message("Data summarized: ", nrow(data), " X ", ncol(data))
        data
    }
    
    ###
    # Remove the "..." in the column names
    ###
    renameColumnNames <- function(data) {
        
        message("Cleaning column names...")
        colnames(data) <- gsub("\\.\\.", "", colnames(data))
        data
    }
    
    ##
    # Write data on disk
    ##
    saveData <- function(data) {
        
        message("Writting data into disk")
        
        fileName <- paste(folder, "/TidyData.txt", sep = "")
        write.csv(data, fileName, quote = FALSE, row.names = FALSE)
    }

    message("beginning")
    loadSourceData()

    features <- loadFeatureLabels()
    colWidths <- rep(16, 561)

    # load training and test datasets
    trainingData <- loadTrainingData(features, colWidths)
    testData <- loadTestData(features, colWidths)

    # merge data
    allData <- mergeData(trainingData, testData)
    
    # clean data
    cleanData <- extractMeasurements(allData)
    
    #add activity names
    cleanData <- mergeActivity(cleanData)
    
    #averages
    summaData <- summarize(cleanData)
    
    #last cleaning - remove "..." from column names
    summaData <- renameColumnNames(summaData)
    
    #write data
    saveData(summaData)

    message("analysis done")
    summaData
}