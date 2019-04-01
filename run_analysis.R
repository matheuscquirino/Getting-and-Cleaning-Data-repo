# The "run_analysis" file provides a tidy-data set to later analysis.
# To that goal, the script is responsible for reading the data, merging it and extracting 
# the relevant information.

library(dplyr)

# Checking if the required directory already exist and extracting it.
if(!dir.exists("UCI HAR Dataset")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, "UCI_HAR_dataset.zip", method="curl")
    unzip("UCI_HAR_dataset.zip")
}

# Reading the training and the test files.
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Reading the feature and the activites files
features <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")

# Merging the training and the test sets to create one data set.
x_combined <- rbind(x_train, x_test)
names(x_combined) <- features$V2

y_combined <- rbind(y_train, y_test)
names(y_combined) <- "activity"

subject_combined <- rbind(subject_train, subject_test)
names(subject_combined) <- "subject"

# Extracting only the measurements on the mean and standard deviation for each measurement.
mean_std_positions <- grep("-mean\\(\\)|-std\\(\\)", names(x_combined))
x_mean_std <- x_combined[,mean_std_positions]

# Merging the data into one data frame
mean_std_data <- cbind(subject_combined, x_mean_std, y_combined)

# Using descriptive activity names to name the activities in the data set
mean_std_data$activity <- activities[mean_std_data$activity, 2]
mean_std_data$activity <- tolower(mean_std_data$activity)
mean_std_data$activity <- gsub("_", " ", mean_std_data$activity)

# Appropriately labels the data set with descriptive activity names.
names(mean_std_data) <- gsub("Acc", "Accelerometer", names(mean_std_data))
names(mean_std_data) <- gsub("Gyro", "Gyroscope", names(mean_std_data))
names(mean_std_data) <- gsub("BodyBody", "Body", names(mean_std_data))
names(mean_std_data) <- gsub("Mag", "Magnitude", names(mean_std_data))
names(mean_std_data) <- gsub("^t", "Time", names(mean_std_data))
names(mean_std_data) <- gsub("^f", "Frequency", names(mean_std_data))
names(mean_std_data) <- gsub("tBody", "TimeBody", names(mean_std_data))
names(mean_std_data) <- gsub("-mean\\(\\)", "Mean", names(mean_std_data), ignore.case = TRUE)
names(mean_std_data) <- gsub("-std\\(\\)", "STD", names(mean_std_data), ignore.case = TRUE)
names(mean_std_data) <- gsub("-freq\\(\\)", "Frequency", names(mean_std_data), ignore.case = TRUE)
names(mean_std_data) <- gsub("angle", "Angle", names(mean_std_data))
names(mean_std_data) <- gsub("gravity", "Gravity", names(mean_std_data))

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy_data <- mean_std_data %>% group_by(subject, activity) %>% summarise_all(mean)
write.table(tidy_data, "tidy_data.txt", sep = "\t", row.name = FALSE)