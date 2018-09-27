
# Function that calculates mean of a pollutant across a specified list of monitors
#     Args: 'Directory' - char vec of length 1 indicating location of csv
#           'pollutant' - name of pollutant to calculate mean (either sulfate or nitrate)
#           'id'        - Integer Vector indicating monitor ID numbers to be used
pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  # For loop to go through each ID and read each table
  sum <- 0;
  length <- 0;
  for (i in id) {
    file <- paste(directory,"/",sprintf("%03d", i), ".csv", sep = "")
    unclean <- read.csv(file, header = TRUE)[pollutant]
    clean <- unclean[!is.na(unclean)]
    sum = sum + sum(clean)
    length = length + length(clean)
  }
  
  return(sum/length)

}