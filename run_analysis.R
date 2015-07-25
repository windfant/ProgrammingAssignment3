#read train data - subject_train, x_train and y_train
subject_train <- read.table("UCI HAR Dataset\\train\\subject_train.txt")
x_train <- read.table("UCI HAR Dataset\\train\\X_train.txt")
y_train <- read.table("UCI HAR Dataset\\train\\Y_train.txt")

#name the columns of subject_train and y_train
names(subject_train)[1] <- "subject"
names(y_train)[1] <- "y"

#read test data - subject_test, x_test and y_test
subject_test <- read.table("UCI HAR Dataset\\test\\subject_test.txt")
x_test <- read.table("UCI HAR Dataset\\test\\X_test.txt")
y_test <- read.table("UCI HAR Dataset\\test\\Y_test.txt")

#name the columns of subject_test and y_test
names(subject_test)[1] <- "subject"
names(y_test)[1] <- "y"

#combine the train and test data for subject, x and y
subject_data <- rbind(subject_train,subject_test)
x_data <- rbind(x_train,x_test)
y_data <- rbind(y_train, y_test)

#read features and extract features with mean and std
features <- read.table("UCI HAR Dataset\\features.txt")
features_mean_std <- grep("mean|std", features[,2])

#extract only the column with mean and std from x
x_data_mean_std <- x_data[,features_mean_std]

#rename the columns of x data
names(x_data_mean_std) <- features[features_mean_std,2]

#merge subject, x and y
merged_data <- cbind(subject_data,x_data_mean_std,y_data)

#read activity labels data 
activity_labels <- read.table("UCI HAR Dataset\\activity_labels.txt")

#name the columns of activity labels data
names(activity_labels) <- c("activity","label")

#merge activity names to the merged data
merged_data_labels <- merge(merged_data, activity_labels, by.x="y", by.y="activity")

#split the merged data by subject and activity
split_by_subject_label <- split(merged_data_labels,list(merged_data_labels$subject,merged_data_labels$label))

#calculate the mean of each variable for each subject and each activity
tidy_dataset<- lapply(split_by_subject_label, function(x) colMeans(x[,names(x_data_mean_std)], na.rm = TRUE))

#write the data set into txt file
write.table(tidy_dataset,"tidy_dataset.txt",row.names=FALSE)
