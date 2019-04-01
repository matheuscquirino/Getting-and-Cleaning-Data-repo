# Coursera - Getting and Cleaning Data Project
This repository has the files related to the Getting and Cleaning Data project assignment. It has the instructions on how to run analysis on the "Human Activity Recognition Using Smartphones" dataset. The goal is to prepare tidy data that can be used for later analysis and to demonstrate the ability to collect, work with and clean a data set.

## Dataset
A full description of the dataset is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Codebook
The CodeBook, called CodeBook.md, describes the variables, the data, and any transformations or work that had been performed to get the data cleaned.

## "run_analysis.R" script
The R script created, called run_analysis.R, does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Dependences
Previously the running process, set your working directory where the files have to be downloaded.
The "dplyr" package needs to be installed to run the script.

## Tidy data
The tidy version of the data, called "tidy_data.text", is exported after going through all the sequences described above.
