###Three final datasets produced are as follows:
####        1] dataset : This data frame respresent the entire data joined together.
####        2] mean_std_dataset : This dataset consisting of the measurements on the mean and standard deviation for each measurement.
####        3] average_dataset :  This dataset represents the average of each variable for each activity and each subject.

###Variable names Used:
####        1] ActivityLabels : This column represents the activities 1 to 6 or the combined data from y_train.txt and y_test.txt .
####        2] SubjectNumber : This column represents the which subject is performing. It represents the combined data from subject_train.txt and subject_test.txt
####        3] ActivityLabelsInteractSubjectNumber : This column can be seen in the average_dataset data frame. This represents the interaction levels of ActivityLabels and SubjectNumber. eg: Thus, WALKING.1 represents an interaction level of WALKING and Subject 1.
####        4] Rest all the variables have similar names to that of the feature set.

###User-defined Functions:
####        1] to_descriptive_activitynames : Converts the ActivityLabels to its corresponding Activity Names. It takes in an integer value and returns the Activity Name.

###Libraries Used:
####        1] reshape2.

###Everything else is explained in the R script file named run_analysis.R. There is only a single script file which should that needs to be executed and care should be taken that the data is extracted and placed in the working directory before execution of the script. The output files will be created in your working directory. 