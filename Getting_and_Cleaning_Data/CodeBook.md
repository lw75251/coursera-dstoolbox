# Code Book

## Overview
Experiments were carried out with a group of 30 volunteers within the ages of 19-48. Each person performed six activites (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a smartphone on their waist. Using its accelerometer and gyroscope we captured the 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50 Hz. 

## File Overview
- features.txt: Names of 561 Features
- activity_labels.txt: Names and ID for each activity
- subject_train.txt: Vector of 7352 integers, 
- subject_test.txt: Vector 2947, denoting ID of he activity related to X_test.txt
- X_train.txt: 7352 Observations of 561 Features for 21 of 30 Volunteers 
- y_train.txt: 7352 Observations that has ID of activity related to each observation in X_train
- X_test.txt: 2947 Observations for 9 of 30 Volunteers
- y_test.txt: 2947 Observations that has ID of activity related to each observation in X_test

## Data Cleansing Steps
1. The Test and Train datasets were loaded and combined then grep was used to find the columns in which mean or std appeared.
2. Abbreviations were expanded and the column names for the combined dataset were fixed and renamed.
3. Used dplyr package functions group_by and summarize_all to create an independent tidy dataset with the average of each variable for each activity and each subject.
