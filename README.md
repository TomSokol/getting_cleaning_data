getting_cleaning_data
=====================

course project for coursera class Getting and Cleaning data

data was downloaded and unzipped maintaining folder structure from following location:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

script run_analysis.R sits as same level as top directory of unzipped data.

ie
/run_analysis.R
/UCI HAR Dataset

read the test and training sets (X_train.txt and X_test.txt) into variables training_set and test_set
read activity labels into training_labels and test_labels

merge the labels into the sets using cbind

combine the test and training sets using rbind

create vector of cols measuring means and std dev + activity labels 
using only mean() and std() measurements

vector col_nums contains column numbers from selected columns below:

1 tBodyAcc-mean()-X
2 tBodyAcc-mean()-Y
3 tBodyAcc-mean()-Z
4 tBodyAcc-std()-X
5 tBodyAcc-std()-Y
6 tBodyAcc-std()-Z
 
41 tGravityAcc-mean()-X
42 tGravityAcc-mean()-Y
43 tGravityAcc-mean()-Z
44 tGravityAcc-std()-X
45 tGravityAcc-std()-Y
46 tGravityAcc-std()-Z
 
81 tBodyAccJerk-mean()-X
82 tBodyAccJerk-mean()-Y
83 tBodyAccJerk-mean()-Z
84 tBodyAccJerk-std()-X
85 tBodyAccJerk-std()-Y
86 tBodyAccJerk-std()-Z

121 tBodyGyro-mean()-X
122 tBodyGyro-mean()-Y
123 tBodyGyro-mean()-Z
124 tBodyGyro-std()-X
125 tBodyGyro-std()-Y
126 tBodyGyro-std()-Z

161 tBodyGyroJerk-mean()-X
162 tBodyGyroJerk-mean()-Y
163 tBodyGyroJerk-mean()-Z
164 tBodyGyroJerk-std()-X
165 tBodyGyroJerk-std()-Y
166 tBodyGyroJerk-std()-Z
 
201 tBodyAccMag-mean()
202 tBodyAccMag-std()
 
214 tGravityAccMag-mean()
215 tGravityAccMag-std()

 
227 tBodyAccJerkMag-mean()
228 tBodyAccJerkMag-std()

240 tBodyGyroMag-mean()
241 tBodyGyroMag-std()
 
253 tBodyGyroJerkMag-mean()
254 tBodyGyroJerkMag-std()
 
266 fBodyAcc-mean()-X
267 fBodyAcc-mean()-Y

269 fBodyAcc-std()-X
270 fBodyAcc-std()-Y
271 fBodyAcc-std()-Z
 
345 fBodyAccJerk-mean()-X
346 fBodyAccJerk-mean()-Y
347 fBodyAccJerk-mean()-Z

348 fBodyAccJerk-std()-X
349 fBodyAccJerk-std()-Y
350 fBodyAccJerk-std()-Z
 
424 fBodyGyro-mean()-X
425 fBodyGyro-mean()-Y
426 fBodyGyro-mean()-Z
427 fBodyGyro-std()-X
428 fBodyGyro-std()-Y
429 fBodyGyro-std()-Z
 
503 fBodyAccMag-mean()
504 fBodyAccMag-std()
 
516 fBodyBodyAccJerkMag-mean()
517 fBodyBodyAccJerkMag-std()

529 fBodyBodyGyroMag-mean()
530 fBodyBodyGyroMag-std()

542 fBodyBodyGyroJerkMag-mean()
543 fBodyBodyGyroJerkMag-std()

562 Activity

reanmed col 562 to "V562" (was V1 from original cbind)


created subset dataframe using those column numbers, mean_std_df

rename activity to meaningful names

create vector of selected column names (colnames) and apply

use ddply from the plyr package to calculate mean based on Activity and write to dataframe final_data

write the data out to a file called tidy_data.txt using write.table


