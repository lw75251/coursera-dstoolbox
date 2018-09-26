
### Function: rankall
# Params: state   - 2-character abbreviation of US States
#         outcome - "heart attack", "heart faliure", or "pneumonia"
#         num - Rank of hospital but can also be "best" or "worst"
# Description: Returns character vector with name of hospital that has the lowest
# 30-day mortality for the specified outcome in that state. Function will validate
# input and throw an error if either state or outcome is invalid.

rankall <- function(outcome, num = "best") {
  
  # Prepares data to be manipulated - only grabs Name, State, Heart_Attack, Heart_Failure, and Pneumonia
  data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")[,c(2,7,11,17,23)]
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  # Input Validation 
  if(! (outcome == "heart attack" || outcome == "heart failure" || outcome == "pneumonia") ) {
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
  if(outcome == "heart attack") {
    data = data[,c(1,2,3)]
  } 
  else if(outcome == "heart failure") {
    data = data[,c(1,2,4)]
  } 
  else if(outcome == "pneumonia") {
    data = data[,c(1,2,5)]
  }
  names(data)[3] = "Deaths"
  data[, 3] = suppressWarnings( as.numeric(data[, 3]) )
  
  # Remove rows with NA
  data = data[!is.na(data$Deaths),]
  
  splited = split(data, data$State)
  ans = lapply(splited, function(x, num) {
    # Order by Deaths and then HospitalName
    x = x[order(x$Deaths, x$Hospital.Name),]
    
    # Return
    if(class(num) == "character") {
      if(num == "best") {
        return (x$Hospital.Name[1])
      }
      else if(num == "worst") {
        return (x$Hospital.Name[nrow(x)])
      }
    }
    else {
      return (x$Hospital.Name[num])
    }
  }, num)
  
  #Return data.frame with format
  return ( data.frame(hospital=unlist(ans), state=names(ans)) )
}