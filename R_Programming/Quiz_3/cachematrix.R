## Function: makeCacheMatrix
# Description: Creates a special vector that contains a list of functions to
# set the value of vector, get the value of vector, set the value of inverse,
# and get the value of inverse

makeCacheMatrix <- function(x = matrix()) {

  # Initially set to NULL but will change if user sets value
  inv <- NULL
  
  # Set function: Sets matrix y to x, and resets inverse to null
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  
  # Get function: Gets the matrix itself
  get <- function() x
  
  # setInverse: Sees if inverse has already been calculated, and if so
  # saves the value into inv
  setinverse <- function(inverse) inv <<- inverse
  
  # getinverse: Gets matrix inverse
  getinverse <- function() inv
  
  # Places each function into list
  list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)	
}


## Function: cacheSolve
# Description: Computes the inverse of the special 'matrix' returned by makeCacheMatrix.
# If the inverse has already been calculated, then the cacheSolve should retrieve inverse
# from cache instead of recalculating it. Otherwise, it computes it.

cacheSolve <- function(x, ...) {
  
  # Determines whether or not inv has already been calculated
  inv <- x$getinverse()
  if(!is.null(inv)) {
    
    # Tells user that it has already been calculated, and no computations will be performed
    message("Getting cached matrix")
    return(inv)
  }
  
  ## NOTE: Only comes here if it does not enter if statement above
  # Retrieves the matrix to compute its inverse
  data <- x$get()
  
  # Find the inverse of matrix
  inv <- solve(data, ...)
  
  # Caches inverse 
  x$setinverse(inv)
  
  # Return this new result
  inv     
}
