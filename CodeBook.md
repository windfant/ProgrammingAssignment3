Dataset to be transformed (Input)
=================================

'features.txt': List of all features (measurements).

'activity_labels.txt': Links the class labels with their activity name. 
	1 WALKING
	2 WALKING_UPSTAIRS
	3 WALKING_DOWNSTAIRS
	4 SITTING
	5 STANDING
	6 LAYING

'train/X_train.txt': Training set of measurements. The variable names are not included, but they are listed in 'features.txt'.

'train/y_train.txt': Training labels. Single variable with range of 1 to 6 and the indication of the values are listed in 'activity_labels.txt'.

'test/X_test.txt': Test set of measurements. (The variables are identical with training set)

'test/y_test.txt': Test labels. (The variable is identical with training labels)

'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample in training set. Its range is from 1 to 30. 

'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample in test set. Its range is from 2 to 24. 

Goal
====
Extract only the measurements on the mean and standard deviation for each measurement. Then prepare a tidy dataset independent tidy data set with the average of each extracted variable for each activity and each subject.

Output
======
'tidy_dataset.txt': a tidy data set with the average of each mean and standard deviation related measurement for each activity and each subject.

How run_analysis.R works (Process)
==================================
Step 1: Read data
	- Read training data - subject_train, x_train and y_train from 'train/subject_train.txt', 'train/X_train.txt' and 'train/y_train.txt' respectively.

	- Read test data - subject_test, x_test and y_test from 'test/subject_test.txt', 'test/X_test.txt' and 'train/y_test.txt' respectively.

	- Read features from 'features.txt'

	- Read labels with their activity name from 'activity_labels.txt'

Step 2: Combine training data and test data for subject, measurements and labels
	- Combine subject_train with subject_test by rows
	- Combine x_train with x_test by rows
	- Combine y_train with y_test by rows

Step 3: Subset mean and standard deviation related measurements.
	- Extract the column numbers for "mean" and "std" from features using grep command
	- Subsetting the combined data of measurements with the extracted column numbers

Step 4: Merge subject, subset of measurements and labels

Step 5: Merge label with activity names

Step 6: Create a tidy data set with the average of each measurement of the merged data for each activity and each subject.
	- Split the merged data by subject and activity using split command
	- Calculate the mean of each variable for each subject and each activity using lapply

Step 7: Write the tidy data set into txt file
	- Write to "tidy_dataset.txt"