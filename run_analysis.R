#----------------------------------------------------------------------------
# Getting and Cleaning Data - Course Project 
# Annie Flippo
#----------------------------------------------------------------------------

# Setup working directory
workDir <- "~/myCourseraProject"

# Check if working directory - create it if it doesn't exist
if (file.exists(workDir)) {
        setwd(file.path(workDir))
} else {
        dir.create(file.path(workDir))
        setwd(file.path(workDir))
}

# Download data zip file if it doesn't exist
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./humanActivityPhoneData.zip")) {
        download.file(fileUrl, destfile = c("./humanActivityPhoneData.zip"), method = "curl")        
}
list.files()

# If datafile directory doesn't exist, unzip it
if (!file.exists("./UCI HAR Dataset")) {
        unzip ("humanActivityPhoneData.zip")
}

# Define data directory
dataDir <- paste( c(workDir, "/UCI HAR Dataset/"), collapse="")

# Define fully-qualified file names
featureFile <- paste( c(dataDir, "features.txt"), collapse="")
activityLabelFile <- paste( c(dataDir, "activity_labels.txt"), collapse="")

# Reading meta data
features <- read.table(featureFile, col.names=c("featureID", "featureName"), header=F)
activity <- read.table(activityLabelFile, col.names=c("activityID", "activityName"), header=F)

# Reading test data
testSubjectFile <- paste(c(dataDir, "test/subject_test.txt"), collapse="")
testSubjects <- read.table(testSubjectFile, col.names="subjectID", header=F)

testMeasurementFile <- paste(c(dataDir, "test/X_test.txt"), collapse="")
testMeasurement <- read.table(testMeasurementFile, col.names=features$featureName, strip.white=T, header=F)

testActivityFile <- paste(c(dataDir, "test/y_test.txt"), collapse="")
testActivity <- read.table(testActivityFile, col.names="activityID", header=F)

# Reading training data
trainSubjectFile <- paste(c(dataDir, "train/subject_train.txt"), collapse="")
trainSubjects <- read.table(trainSubjectFile, col.names="subjectID", header=F)

trainMeasurementFile <- paste(c(dataDir, "train/X_train.txt"), collapse="")
trainMeasurement <- read.table(trainMeasurementFile, col.names=features$featureName, strip.white=T, header=F)

trainActivityFile <- paste(c(dataDir, "train/y_train.txt"), collapse="")
trainActivity <- read.table(trainActivityFile, col.names="activityID", header=F)

#----------------------------------------------------------------------------
# Instruction 1. Merges the training and the test sets to create one data set
#----------------------------------------------------------------------------
allSubjects <- rbind(testSubjects, trainSubjects)

allMeasurement <- rbind(testMeasurement, trainMeasurement)
#----------------------------------------------------------------------------
# Note 4a. Put the more meaningful feature name as column labels
#----------------------------------------------------------------------------
colnames(allMeasurement) <- features$featureName

allActivity <- rbind(testActivity, trainActivity)

# Combining all train and test data into one data set
allData <- cbind(allSubjects, allActivity, allMeasurement)
View(allData)


#----------------------------------------------------------------------------
# Instruction 2. Extracts only the measurements on the mean and standard 
#                deviation for each measurement
#----------------------------------------------------------------------------
# Get the column with only mean or std in the colnames
# This pattern will only data for "mean" or "std" header
meanStdColumns <- grep("mean|std", colnames(allData), ignore.case=TRUE)

# Build the data set with mean and standard deviation for each measurement
# The dataset includes the column1: subjectID and column 2: activityID
meanStdData <- allData[ , c(1, 2, meanStdColumns)]

#----------------------------------------------------------------------------
# Instruction 3. Uses descriptive activity names to name the activities
#                in the data set
#----------------------------------------------------------------------------
# Merge large data set with the activity (lookup table)
# This will append the activityName column to the end of the data frame
meanStdData <- merge(activity, meanStdData, by="activityID")
View(meanStdData)

# View just the activityID and activityName columns to verify the mapping was correct
id_activity_columns <- c("activityID", "activityName")

#----------------------------------------------------------------------------
# Instruction 4. Appropriately labels the data set with descriptive activity names                
#----------------------------------------------------------------------------
# This was done earlier as allMeasurement object was built
# See Note 4a above.
#
# Alternatively, you can run View(meanStdData) again
# View(meanStdData)

#----------------------------------------------------------------------------
# Instruction 5. Creates a second, independent tidy data set with the average 
#                of each variable for each activity and each subject                
#----------------------------------------------------------------------------

# Create a new data frame but drop the non-numeric column of activityName
tidyData <- meanStdData[, !names(meanStdData) %in% "activityName"]

# Get average measurment by subjectID and activityID combination
tidyData <- aggregate(tidyData, by=list(tidyData$subjectID, tidyData$activityID), 
                     FUN=mean, na.rm=TRUE)


# list redundant group heading to drop since they are already 
# represented by activityID and subjectID
drop <- c("Group.1", "Group.2")
tidyData <- tidyData[, !(names(tidyData) %in% drop)]

# Merge the desciptive names for the activities
tidyData <- merge(activity, tidyData, by="activityID")

# Prepend "Avg-" to measurements to note that it's the average per subjectID and activityID
tidyHeader <- lapply(names(tidyData[4:ncol(tidyData)]), function (x) paste(c('Avg-',x), collapse="") )
tidyHeader <- c("activityID", "activityName", "subjectID", tidyHeader)
colnames(tidyData) <- tidyHeader

outputFile <- paste(c(dataDir, "tidyData.txt"), collapse="")
write.table(tidyData, file=outputFile )

View(tidyData)

