# Code Book for tidyData.txt
# Annie Flippo

The run_analysis.R script creates the resultant summary datafile, tidyData.txt. This script uses the data from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) published by UCI and generates a summary of measurments by subjectID and activityID. 

The raw data was downloaded from the [course project](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

# Output
* tidyData.txt is filtered to capture the average mean and standard deviation of the axial measurment per subjectID while doing a particular activity
* tidyData.txt contains 181 rows by 89 columns including the header row
* The summary data includes a header of the description of the columns
* Each column header is within double-quotes (" ")
* The rows of the summary data are separated by Unix newline 
* The columns of the summary data are separated by white space

# Variables
* 1st column - activityID
* 2nd column - activityName (as provided by the raw datafile, activity_labels.txt)
    - WALKING
    - WALKING_UPSTAIRS
    - WALKING_DOWNSTAIRS
    - SITTING
    - STANDING
    - LAYING
* 3rd column - subjectID
* 4th - 89th columns - Average of the specific mean or standard deviation of the axial measurement

# Summary
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

The resultant tidyData.txt calculated the average measurements for the 30 subjects and 6 activities involved in the experiment. 

# Notes
The script is created by Annie Flippo for the Coursera Course Project, Getting and Cleaning Data, offered by the [John Hopkins Bloomberg School of Public Health's Data Science Specialization Serie](https://www.coursera.org/course/getdata).
