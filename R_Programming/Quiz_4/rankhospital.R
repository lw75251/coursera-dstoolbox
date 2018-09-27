
### Function: rankhospital
# Params: state   - 2-character abbreviation of US States
#         outcome - "heart attack", "heart faliure", or "pneumonia"
#         num - Rank of hospital but can also be "best" or "worst"
# Description: Returns character vector with name of hospital that has the nth lowest
# 30-day mortality for the specified outcome in that state. Function will validate
# input and throw an error if either state, outcome, or num is invalid.

rankhospital <- function(state, outcome, num = "best") {
  
  # Prepares data to be manipulated - only grabs Name, State, Heart_Attack, Heart_Failure, and Pneumonia
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")[,c(2,7,11,17,23)]
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  # Input Validation
  if( !( state %in% data$State)) {
    stop("invalid state")
  }
  
  else if ( !(outcome %in% valid_outcomes) ) {
    stop("invalid outcome")
  }
  
  
  # If num is a string, it must be "best" or "worst"
  if(class(num) == "character"){
    if (! (num == "best" || num == "worst")){
      stop("invalid number")
    }
  }
  
  # Prepares data by filtering out unnecessary states and outcomes
  # leaving only Name and Deaths pertaining to specified outcome
  data = data[data$State==state,]
  data = data[,c(1,3,4,5)]
  if(outcome == "heart attack") {
    data = data[,c(1,2)]
  } 
  else if(outcome == "heart failure") {
    data = data[,c(1,3)]
  } 
  else if(outcome == "pneumonia") {
    data = data[,c(1,4)]
  }
  names(data)[2] = "Deaths"
  data[, 2] = suppressWarnings( as.numeric(data[, 2]) )
  
  # Remove rows with NA
  data = data[!is.na(data$Deaths),]
  
  # num > numrows or num < 0 then return NA
  if( (class(num) == 'numeric' && num < 0) || 
      (class(num) == "numeric" && num > nrow(data)) ) {
    return (NA)
  }
  
  # Order by Deaths and then Name
  data = data[order(data$Deaths, data$Hospital.Name),]
  
  # If num is best we grab the first entry, and if worst we grab
  # the last entry. Otherwise, we grab the number specified by num
  if(class(num) == "character") {
    if(num == "best") {
      return (data$Hospital.Name[1])
    }
    else if(num == "worst") {
      return (data$Hospital.Name[nrow(data)])
    }
  }
  else {
    return (data$Hospital.Name[num])
  }
}
