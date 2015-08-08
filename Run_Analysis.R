## First, load  the (training and test) data files.
## setwd("~/UCI HAR Dataset")
## Below, I include more of the filepath than necessary. 
## with the setwd command above, everything should work fine with just the filename.
trainX <- read.table("~/UCI HAR Dataset/train/X_train.txt")
dim(trainX) 
## Should be 7352 by 561
trainY <- read.table("~/UCI HAR Dataset/train/y_train.txt")
table(trainY)
trainSubject <- read.table("~/UCI HAR Dataset/train/subject_train.txt")
testX <- read.table("~/UCI HAR Dataset/test/X_test.txt")
dim(testX) 
## Should be 2947 by 561
testY <- read.table("~/UCI HAR Dataset/test/y_test.txt") 
table(testY) 
testSubject <- read.table("test/subject_test.txt")
## 2nd, merge the data files into one data set.
joinX <- rbind(trainX, testX)
dim(joinX) 
## Should be 10299 by 561
joinY <- rbind(trainY, testY)
dim(joinY) 
## Should be 10299 by 1
joinSubject <- rbind(trainSubject, testSubject)
dim(joinSubject)
## Should also return 10299 by 1
## 3rd, extract only the mean and standard deviation for each measurement. 
features <- read.table("features.txt")
dim(features)  
## Should be 561 by 2
meanStd <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStd) 
## Should be 66
joinX <- joinX[, meanStd]
dim(joinX) 
## Should be 10299 by 66
names(joinData) <- gsub("\\(\\)", "", features[meanStd, 2]) 
## remove parentheses i.e. "()"
names(joinData) <- gsub("-", "", names(joinData)) 
## remove hyphen i.e. "-" in column names 

## 4th, use descriptive names to name the activities in the data set
activity <- read.table("activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityY <- activity[joinY[, 1], 2]
joinY[, 1] <- activityY
names(joinY) <- "activity"

## 5th, appropriately label the data set with descriptive activity names. 
names(joinSubject) <- "subject"
cleanData <- cbind(joinSubject, joinY, joinX)
dim(cleanData) 
## Should be 10299 by 68
write.table(cleanData, "merged_data.txt") 
## creates the "merged_data.txt" file with the first dataset

## 6th, create a second, independent tidy data set with the average of each variable for each activity and each subject. 
subjectLen <- length(table(joinSubject)) # 30
activityLen <- dim(activity)[1] # 6
columnLen <- dim(cleanData)[2]
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(cleanData)
row <- 1
for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    result[row, 1] <- sort(unique(joinSubject)[, 1])[i]
    result[row, 2] <- activity[j, 2]
    bool1 <- i == cleanData$subject
    bool2 <- activity[j, 2] == cleanData$activity
    result[row, 3:columnLen] <- colMeans(cleanData[bool1&bool2, 3:columnLen])
    row <- row + 1
  }
}
write.table(result, "data_with_means.txt") 
## creates the "data_with_means.txt" file with the second dataset
data <- read.table("data_with_means.txt")