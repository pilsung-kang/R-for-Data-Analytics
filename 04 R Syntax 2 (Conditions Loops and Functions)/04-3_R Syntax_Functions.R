# Functions -------------------------------------------------------

# Same operation but different outputs
distance <- c(148, 182, 173, 166, 109, 141, 166)

mean_and_sd1 <- function(x) {
  avg <- mean(x)
  sdev <- sd(x)
  return(c(mean=avg, SD=sdev))
}

mean_and_sd1(distance)

mean_and_sd2 <- function(x) {
  avg <- mean(x)
  sdev <- sd(x)
  c(mean=avg, SD=sdev)
  return(avg)
}

mean_and_sd2(distance)

# Return the result with return()
oddcount <- function(x) {
  k <- 0
  print("odd number calculator")
  for (n in 1:x) {
    if (n %% 2 == 1) {
      cat(n, "is an odd number. \n")
      k <- k+1
    }
  }
  return(k)
}

oddcount(10)

# Return the result without return() but explicitly designate the object
oddcount <- function(x) {
  k <- 0
  print("odd number calculator")
  for (n in 1:x) {
    if (n %% 2 == 1) {
      cat(n, "is an odd number. \n")
      k <- k+1
    }
  }
  k
}

oddcount(10)

# Return the result without return() and explicit designation
oddcount <- function(x) {
  k <- 0
  print("odd number calculator")
  for (n in 1:x) {
    if (n %% 2 == 1) {
      cat(n, "is an odd number. \n")
      k <- k+1
    }
  }
}

oddcount(10)

mean_and_sd3 <- function(x = rnorm(10)) {
  avg <- mean(x)
  sdev <- sd(x)
  return(c(mean=avg, SD=sdev))
}

mean_and_sd3(distance)
mean_and_sd3()


# Function arguments
addTheLog <- function(first, second) {first + log(second)}
# Exact names
addTheLog(second=exp(4),first=1)
# Partially matching names
addTheLog(s=exp(4),first=1)
# Argument order
addTheLog(1,exp(4))

# Function example 1
findrepeats <- function(x, k) {
  n <- length(x)
  repeats <- NULL
  for (i in 1:(n-k+1)) {
    if(all(x[i:(i+k-1)] == 1)) repeats <- c(repeats, i)
  }
  return(repeats)
}

vec <- c(1,1,1,0,0,1,0,1,1,0,1,1,1)
findrepeats(vec,2)
findrepeats(vec,3)
findrepeats(vec,4)

# Example 2: Kendall's tau
findud <- function(v) {
  vud <- v[-1] - v[-length(v)]
  return(ifelse(vud >0, 1, -1))
}

udcorr <- function(x,y) {
  ud <- lapply(list(x,y), findud)
  return(mean(ud[[1]] == ud[[2]]))
}

temp <- c(10, 15, 13, 17, 20)
pressure <- c(900, 920, 890, 940, 920)

udcorr(temp,pressure)