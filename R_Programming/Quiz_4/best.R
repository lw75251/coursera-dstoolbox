# Plots 30-day mortality rates for heart attacks
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)

# Makes a simple histogram
outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])

### Function: Best
# Params: state   - 2-character abbreviation of US States
#         outcome - "heart attack", "heart faliure", or "pneumonia"
# Description: Returns character vector with name of hospital that has the lowest
# 30-day mortality for the specified outcome in that state. Function will validate
# input and throw an error if either state or outcome is invalid.
best <- function(state, outcome) {

  # Prepares data to be manipulated
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  data[,11] <- as.numeric(data[,11]) # heart attack
  data[,17] <- as.numeric(data[,17]) # heart failure
  data[,23] <- as.numeric(data[,23]) # pneumonia
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  # Input Validation
  if ( !(state %in% data$State) ) {
    stop("invalid state")
  } 
  
  else if ( !(outcome %in% valid_outcomes) ) {
    stop("invalid outcomes")
  }
  
  else {
    
    # Gets correct column number depending on outcome
    col_num <- 0
    if ( outcome == "heart attack" ) {
      col_num = 11
    }
    else if ( outcome == "heart failure") {
      col_num = 17
    }
    else {
      col_num = 23
    }
    
    # Subsets original data to find correct state and outcome values
    # and calculates min
    statesub <- data[data[,7]==state,]
    outcomesub <- statesub[,col_num]
    min <- min(outcomesub, na.rm = TRUE)
    min_index <- which(outcomesub == min )
    name <- statesub[min_index,2]
    
    return(name)
  }
   
}

