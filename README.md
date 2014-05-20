# How to use run_analysis.R

This script uses the data from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) published by UCI and generates a summary of measurments by subjectID and activityID.  This script is created to work for the Mac OS or unix environment. A quick modification on directory structure is needed to make it work for Windows OS which is not included here.


# Repository Contents
* README.md - this file
* CodeBook.md - a description of the summary measurements output file
* run_analysis.R - The R script

# Requirements
This script is verified on
R version 3.0.3 (2014-03-06) -- "Warm Puppy"
Copyright (C) 2014 The R Foundation for Statistical Computing
Platform: x86_64-apple-darwin10.8.0 (64-bit)

The script will run View([dataset]) 3 times during execution.  If the script is invoked in R-Studio Version 0.98.501, the intermittent datasets and the final tidyData will be displayed. 

# Usage
You can run the script in R Console or R-Studio by executing:

```
source('run_analysis.R')
```

The script will create a directory called $HOME/myCourseProject if it doesn't already exist, download data from UCI and unzip its content.  The summary file can be found at  $HOME/myCourseProject/UCI HAR Dataset/tidyData.txt

# Notes
The script is created by Annie Flippo for the Coursera Course Project, Getting and Cleaning Data, offered by the [John Hopkins Bloomberg School of Public Health's Data Science Specialization Serie](https://www.coursera.org/course/getdata).