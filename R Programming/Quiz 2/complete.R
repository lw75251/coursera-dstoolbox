
# Function that reports number of completely observed cases in each data file
#     Args: 'Directory' - char vec of length 1 indicating location of csv
#           'id'        - Integer Vector indicating monitor ID numbers to be used
complete <- function(directory, id = 1:332) {
  
  df <- data.frame(id=integer(), nobs=integer())
  
  # For loop to go through each ID and read each table
  for (i in id) {
    file <- paste(directory,"/",sprintf("%03d", i), ".csv", sep = "")
    unclean <- read.csv(file, header = TRUE)
    clean <- complete.cases(unclean)
    length <- sum(clean)
    df[nrow(df)+1,] = list(i,length)
  }
  
  return(df)

}