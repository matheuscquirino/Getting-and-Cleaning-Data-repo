# CodeBook
The "CodeBook.md" describes the variables, the data, and any transformations or work that had been performed to get the data cleaned.

## Data source
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Data set information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six 
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the 
waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant 
rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into 
two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding 
windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion 
components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to 
have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was 
obtained by calculating variables from the time and frequency domain.

## Data files

The dataset includes the following files required by "run_analysis.R" script:

1. "train/X_train.txt": Training set.
2. "test/X_test.txt": Test set.
3. "train/y_train.txt": Training labels.
4. "test/y_test.txt": Test labels.
5. "test/subject_test.txt": Each row identifies the subject who performed the train activity.
5. "train/subject_train.txt": Each row identifies the subject who performed the train activity.
5. "features.txt": List of all features.
6. "activity_labels.txt": Links the class labels with their activity name.

## "run_analysis.R" description

The following steps describe the cleaning process.
#### 1. Downloads the dataset
The "UCI HAR Dataset" folder is downloaded and extracted when it doesn't already exists. 

#### 2. Reads the train and test files
1. x_train <- test/X_test.txt
2. x_test <- test/X_test.txt
3. y_train <- train/y_train.txt
4. y_test <- test/y_test.txt
5. subject_test <- test/subject_test.txt
6. subject_train <- test/subject_train.txt

#### 3. Reads the feature and activity files
1. features <- features.txt
2. activities <- activity_labels.txt

#### 4. Merges the train and the test sets to create one data set.
1. x_combined is created merging the x_train and the x_test data sets.
2. x_combined is named in accordance to the names of the functions in the feature data set.
3. y_combined is created merging the y_train and the y_test data sets.
4. y_combined is named "activity".
5. subject_combined is created merging the subject_test and the subject_train data sets.
6. subject_combined is named "subject".

#### 5. Extracts only the measurements on the mean and standard deviation for each measurement.
mean_std_positions is created from the names of the x_combined data that have the mean or the 
standard deviation, by using the grep() function. It represents the vector with the position where the mean 
and standard deviation variables occur.
x_mean_std is the data set extracted by selecting the x_combined elements in the mean_std_positions.

#### 6. Merges the data into one data frame
mean_std_data is the data set created by combining the subject_combined, x_mean_std and y_combined with the cbind() function.

#### 7. Uses descriptive activity names to name the activities in the data set
1. The numbers in "activity" column of the "mean_std_data" are replaced with corresponding activity taken from second column of the
"activities" variable.
2. The names of the "activity" column in the mean_std_data are replaced as tolower.
3. The "_" characters are replaced to " " by using the gsub() function.

#### 8. Appropriately labels the data set with descriptive variable names
1. All "Acc" in column’s name replaced by "Accelerometer"
2. All "Gyro" in column’s name replaced by "Gyroscope"
3. All "BodyBody" in column’s name replaced by "Body"
4. All "Mag" in column’s name replaced by "Magnitude"
5. All "start" with character f in column’s name replaced by "Frequency"
6. All "start" with character t in column’s name replaced by "Time"
7. All "-mean()" in column's name replaced by "Mean"
8. All "-std()" in column's name replaced by "STD"
9. All "-freq()" in column's name replaced by "Frequency"
10. All "angle" in column's name replaced by "Angle"
11. All "gravity" in column's name replaced by "Gravity"

#### 9. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
The final "tidy_data" is created by sumarazing the mean_std_data taking the means of each variable for each activity and each subject, 
after groupped by subject and activity.
