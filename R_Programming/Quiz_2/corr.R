
# Function that calculates the correlation between sulfate and nitrate for monitor locations
# where the number of completely observed cases is greater than the threshold
#     Args: 'Directory' - char vec of length 1 indicating location of csv
#           'threshold' - numeric vector of length 1 indicating # of completely observed observations
corr <- function(directory, threshold = 0) {
  corr_vec = numeric(332);
  
  # For loop to go through each ID and read each table
  for (i in 1:332) {
    file <- paste(directory,"/",sprintf("%03d", i), ".csv", sep = "")
    unclean <- read.csv(file, header = TRUE)
    crows <- complete.cases(unclean)
    num_complete <- sum(crows)
    clean <- unclean[crows,]
    
    if( num_complete > threshold ) {
      corr_vec[i] = cor(clean["sulfate"], clean["nitrate"])
    }
    else {
      corr_vec[i] = 0;
    }
  }
  return( corr_vec[corr_vec!=0] )
}