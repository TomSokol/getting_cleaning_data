#run_analysis.R

# Here are the data for the project:
#     
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# You should create one R script called run_analysis.R that does the following. 
# 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#read the test and training sets into variables
training_set  <- read.table('UCI HAR Dataset/train/X_train.txt')
test_set  <- read.table('UCI HAR Dataset/test/X_test.txt')

#merge with the activity labels
training_labels  <- read.table('UCI HAR Dataset/train/y_train.txt')
test_labels  <- read.table('UCI HAR Dataset/test/y_test.txt')

training_set  <- cbind(training_set,training_labels)
test_set <- cbind(test_set,test_labels)

#combine the two
combined_set  <- rbind(training_set, test_set)

#create vector of cols measuring means and std dev + activity labels (final column)
#using only mean() and std() measurements

colnames(combined_set)[562] <- "V562" #data subset leaves out final column if I don't rename.  Originally V1 (in position 562)

col_nums  <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266:271, 345:350)
col_nums  <- c(col_nums, 424:429, 503, 504, 516, 517, 529, 530, 542, 543, 562 )

#create dataframe with only selected columns
mean_std_df  <- combined_set[,col_nums]

#rename activity to meaningful names
mean_std_df$V562[mean_std_df$V562==1]  <-  "WALKING"
mean_std_df$V562[mean_std_df$V562==2]  <-  "WALKING_UPSTAIRS"
mean_std_df$V562[mean_std_df$V562==3]  <-  "WALKING_DOWNSTAIRS"
mean_std_df$V562[mean_std_df$V562==4]  <-  "SITTING"
mean_std_df$V562[mean_std_df$V562==5]  <-  "STANDING"
mean_std_df$V562[mean_std_df$V562==6]  <-  "LAYING"

#give meaningful column names
col_names  <- c("tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z")
col_names  <- c(col_names,"tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z","tGravityAcc-std()-X","tGravityAcc-std()-Y","tGravityAcc-std()-Z")
col_names  <- c(col_names,"tBodyAccJerk-mean()-X","tBodyAccJerk-mean()-Y","tBodyAccJerk-mean()-Z","tBodyAccJerk-std()-X","tBodyAccJerk-std()-Y","tBodyAccJerk-std()-Z")
col_names  <- c(col_names,"tBodyGyro-mean()-X","tBodyGyro-mean()-Y","tBodyGyro-mean()-Z","tBodyGyro-std()-X","tBodyGyro-std()-Y","tBodyGyro-std()-Z")
col_names  <- c(col_names,"tBodyGyroJerk-mean()-X","tBodyGyroJerk-mean()-Y","tBodyGyroJerk-mean()-Z","tBodyGyroJerk-std()-X","tBodyGyroJerk-std()-Y","tBodyGyroJerk-std()-Z")
col_names  <- c(col_names,"tBodyAccMag-mean()","tBodyAccMag-std()","tGravityAccMag-mean()","tGravityAccMag-std()","tBodyAccJerkMag-mean()","tBodyAccJerkMag-std()")
col_names  <- c(col_names,"tBodyGyroMag-mean()","tBodyGyroMag-std()","tBodyGyroJerkMag-mean()","tBodyGyroJerkMag-std()","fBodyAcc-mean()-X","fBodyAcc-mean()-Y","fBodyAcc-mean()-Z")
col_names  <- c(col_names,"fBodyAcc-std()-X","fBodyAcc-std()-Y","fBodyAcc-std()-Z", "fBodyAccJerk-mean()-X","fBodyAccJerk-mean()-Y","fBodyAccJerk-mean()-Z") 
col_names  <- c(col_names,"fBodyAccJerk-std()-X","fBodyAccJerk-std()-Y","fBodyAccJerk-std()-Z","fBodyGyro-mean()-X","fBodyGyro-mean()-Y","fBodyGyro-mean()-Z")
col_names  <- c(col_names,"fBodyGyro-std()-X", "fBodyGyro-std()-Y","fBodyGyro-std()-Z","fBodyAccMag-mean()","fBodyAccMag-std()","fBodyBodyAccJerkMag-mean()","fBodyBodyAccJerkMag-std()")
col_names  <- c(col_names,"fBodyBodyGyroMag-mean()","fBodyBodyGyroMag-std()","fBodyBodyGyroJerkMag-mean()","fBodyBodyGyroJerkMag-std()","Activity")              

colnames(mean_std_df)  <- col_names

#use ddply from the plyr package to calculate mean based on Activity
library(plyr)
final_data  <- ddply(mean_std_df, .(Activity), numcolwise(mean))

#write the data out to a file called tidy_data.txt
write.table(final_data, file="tidy_data.txt",row.name=FALSE)
