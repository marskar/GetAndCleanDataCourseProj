This readme file corresponds to the GetAndCleanDataCourseProj repo, which contains the files for my Coursera Getting and Cleaning Data course project. 

If you would like to repeat the steps I took, first you have to download and unzip the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
Then, set the resulting folder as the current working directory.
Now you can use source(“Run_Analysis.R") command in RStudio. For this to work, the R script has to be in current working directory.

In the end, you should have two output files in the working directory:
	- merged_data.txt, which contains a 10299 by 68 data frame called cleanData.
	- data_with_means.txt, which contains a 180 by 68 data frame called result.
