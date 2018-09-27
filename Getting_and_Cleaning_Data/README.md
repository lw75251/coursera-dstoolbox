File: run_analysis.R
Description: Takes in UCI Dataset on Human Activity Recognition Using Smartphones. Note,
you must place run_analysis.R inside the UCI Directory that contains all data folders
and files. 

run_analysis will merge the training and test sets to create one data. Furthermore,
it will only extract the mean and standard deviation for each measurement while
appropriately labeling data set and expanding any abbreviated measurements.
It then creates a second, independent tidy data set with the average of each variable
for each activity and each subject.
