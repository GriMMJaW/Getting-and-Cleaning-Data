##The code is written and executed in RStudio Version 0.98.501 – © 2009-2013 RStudio, Inc.
##The underlying R version used is R 3.0.3 GUI 1.63 Snow Leopard build (6660).

##The below code assumes that the folder 'UCI HAR Dataset' is placed in your working directory.


##The two required datasets produced are : 
####    1] mean_std_dataset : This dataset consisting of the measurements on the mean and standard deviation for each measurement.
####    2] average_dataset :  This dataset represents the average of each variable for each activity and each subject

###Packages required : reshape2
install.packages("reshape2")
library(reshape2)


##1]Merges the training and the test sets to create one dataset
####Preparing column names for X_train and X_test
featurenames <- read.table("UCI HAR Dataset/features.txt",header = FALSE,check.names = FALSE)
colnames <- as.character(featurenames[,2])

####Reads and creates the training dataset.
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE,col.names = colnames,check.names = FALSE)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE, col.names = c("ActivityLabels"))
subjecttrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE,col.names = c("SubjectNumber"))
train <- cbind(xtrain,ytrain,subjecttrain)

####Reads and creates the test dataset.
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE,col.names = colnames, check.names = FALSE)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE, col.names = c("ActivityLabels"))
subjecttest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE, col.names = c("SubjectNumber"))
test <- cbind(xtest,ytest,subjecttest)

####test and train are the final testing and training datasets which are binded together to form a complete final 'dataset'.

####This is the final dataset which is created after merging train and test data.
dataset <- rbind(train,test)


##2] Extracts only the measurements on the mean and standard deviation for each measurement.
#### The grep function partially matches column names having mean() or std() in them.
mean_col_names <- grep(pattern = "mean()",colnames)
std_col_names <- grep(pattern = "std()",colnames)

#### col_names is a numeric vector used to store the indexes of heading names of all the mean and std functions from the 561 available feature set.
col_names <- c()
col_names <- append(col_names,mean_col_names)
col_names <- append(col_names,std_col_names)
col_names <- sort(col_names)
col_names <- append(col_names,c(562,563), after = 0)
####The below 'mean_std_dataset' is the dataset consisting of the measurements on the mean and standard deviation for each measurement.
mean_std_dataset <- dataset[,col_names]
####The below 3 lines get the working directory and writes the file 'mean_std_dataset.csv' in the working directory.
workingdirectory <- getwd()
outputdirectory = paste(workingdirectory,"/mean_std_dataset.csv",sep="")
write.csv(mean_std_dataset,outputdirectory)


##3] Uses descriptive activity names to name the activities in the data set.
##4] Appropriately labels the data set with descriptive activity names.
#### The below defined function converts the labels to their corresponding activity names.
to_descriptive_activitynames <- function(x)
{
    switch(as.character(x),
           "1" = "WALKING",
           "2" = "WALKING_UPSTAIRS",
           "3" = "WALKING_DOWNSTAIRS",
           "4" = "SITTING",
           "5" = "STANDING",
           "LAYING") 
}
#### The below statement applied the to_descriptive_activitynames function to the dataset.
mean_std_dataset$ActivityLabels <- sapply(mean_std_dataset$ActivityLabels,to_descriptive_activitynames)
View(mean_std_dataset$ActivityLabels)


##5]Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
####colnames is used to store the indexes of column names of the feature set having just mean() in them.
colnames <- names(mean_std_dataset)
colnames <- grep(pattern = "mean()",colnames)
colnames <- append(colnames,c(1,2),after = 0)
mean_dataset <- mean_std_dataset[,colnames]
####The below code creates a data frame having interactions of ActivityLabels and Subject Number
mydata <- data.frame(ActivityLabelsInteractSubjectNumber=interaction(as.factor(mean_dataset[,1]), as.factor(mean_dataset[,2])), mean_dataset[,3:ncol(mean_dataset)])

####Melts the data and creates the required dataset named 'average_dataset' which represents the average of each variable for each activity and each subject.
melteddata <- melt(mydata,id = "ActivityLabelsInteractSubjectNumber")

####The below 'average_dataset' is the required dataset.
average_dataset <- dcast(melteddata,ActivityLabelsInteractSubjectNumber~variable,mean)
####The below 3 lines get the working directory and writes the file 'average_dataset.csv' in the working directory.
workingdirectory <- getwd()
outputdirectory = paste(workingdirectory,"/average_dataset.csv",sep="")
write.csv(average_dataset,outputdirectory)

View(average_dataset)


