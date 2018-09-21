setwd("C:\\Users\\Leon Wu\\Desktop\\Online Courses\\coursera-dstoolbox\\R Programming\\Quiz 1")

df <- read.csv("hw1_data.csv")
df <- subset(df, Month == 5 )
may <- df$Ozone
max(may[!is.na(may)])