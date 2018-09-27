library(dplyr)

# Get Labels and Features and changes data format
activity_labels <- read.table("activity_labels.txt")
colnames(activity_labels) <- c("activityId","activityLabel")

features <- read.table("features.txt", as.is = TRUE)

# Grabs the mean and std columns for each measurement from test dataset
test <- read.table("test/X_test.txt")
testAct <- read.table("test/y_test.txt")
testSub <- read.table("test/subject_test.txt")
test <- cbind(testSub,testAct, test)

# Grabs the mean and std columns for each measurement from train dataset
train <- read.table("train/X_train.txt")
trainAct <- read.table("train/y_train.txt")
trainSub <- read.table("train/subject_train.txt")
train <- cbind(trainSub,trainAct, train)

# Grabso nly the mean and sd for each measurement
combined <- rbind(train,test)
colnames(combined) <- c("subject", features[,2], "activity")
keep <- grepl("subject|activity|mean|std", colnames(combined))
combined <- combined[,keep]

# Replace activity values with factor levels
combined$activity <- factor(combined$activity, levels = activity_labels[,1],
                            labels = activity_labels[,2])

# Label datset with descriptive variable names
combinedCols <- colnames(combined)
combinedCols <- gsub("[\\(\\)-]", "", combinedCols)

# Abbreviations and Expansions
a_e <- data.frame("Abbrev"=c("^f","^t","Acc","Gyro","Mag","Freq","mean","std"),
                  "Expand"=c("frequencyDomain","timeDomain","Accelerometer",
                             "Gyroscope","Magnitude","Frequency","Mean","StandardDeviation"))

# Expands Abbreviations for each measurement
for( i in 1:length(a_e$Abbrev)) {
  combinedCols <- gsub(a_e[i,1],a_e[i,2],combinedCols)
}

# Rename column names
colnames(combined) <- combinedCols

# Groups by means and outputs
combinedMeans <- combined %>%
  group_by(subject, activity) %>%
  summarize_all(funs(mean))

# Output to tidy_data.txt
write.table(combined, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)