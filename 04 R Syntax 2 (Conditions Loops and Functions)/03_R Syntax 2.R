# Conditions
r <- 1
if (r==4) {
  print("The valus of r is 4")
} else {
  print("The valus of r is not 4")
}

r <- 4
if (r==4) {
  print("The value of r is 4")
} else {
  print("The value of r is not 4")
}

# Caution!
r <- 4
if (r==4) {
  print("The value of r is 4")
} 
else {
  print("The value of r is not 4")
}

# Computations are possible in the statements
r <- 3
if (r < 5) {
  cat("The value of squared r is", r^2)
} else {
  cat("The value of squared root of r is", sqrt(r))
}

# the results of functions can be a condition
carbon <- c(10, 12, 15, 19, 20)
mean(carbon)
median(carbon)

if (mean(carbon) > median(carbon)) {
  print ("Mean > Median")
} else {
  print ("Median <= Mean")
}

# Simple form
x <- 1
if(x > 0) print("Non-negative number") else print("Negative number")

# variable initialization with if statement
x <- -2
y <- if(x > 0) 1 else -1
y

# if-else ladder
x <- 0
if (x < 0) {
  print("Negative number")
} else if (x > 0) {
  print("Positive number")
} else
print("Zero")

# Product price calculator w.r.t different category
category <- 'A'
price <- 10
if (category =='A'){
  cat('A vat rate of 8% is applied.','The total price is', price*1.08)  
} else if (category =='B'){
  cat('A vat rate of 10% is applied.','The total price is', price*1.10)  
} else {
  cat('A vat rate of 20% is applied.','The total price is', price*1.20)  
}

# ifelse example
x <- 1:10
y <- ifelse(x%%2 == 0, "even", "odd")
y

# Loop: for statement
n <- c(1:10)
for (i in n) {
  print(i^2)
}

# For loop with an if statement inside
n <- c(1:10)
for (i in n){
  if (i %% 2 == 0) {
    cat(i, "is an even number \n")
  } else {
    cat(i, "is an odd number \n")
  }
}

# Multiple for loops
mat <- matrix(data = seq(11, 20, by=1), nrow = 5, ncol =2)
mat

# Create the loop with r and c to iterate over the matrix
for (r in 1:nrow(mat)){   
  for (c in 1:ncol(mat)){  
    cat("The square of row", r, "and column", c, "is", mat[r,c]^2, "\n")
  }
}

# While loop Example 1
i <- 1
while (i <= 10) {
  i <- i+4
  print(i)
}

# While loop example 2
# Set variable price
price <- 100

# Loop variable counts the number of loops 
loop <- 1

# Set the while statement
while (price > 95){
  
  # Add a random variation between -10 and 10 to the current price
  price <- price + sample(-10:10, 1)
  
  # Print the number of loop and price
  cat("The", loop, "-th price is", price, "\n")
  
  # Count the number of loop
  loop = loop +1 
}

# repeat-break example 1
i <- 1
repeat {
  i <- i+4
  print(i)
  if (i > 10) break
}

# repeat-break example 2: Infinite loop prevention
price <- 100
loop = 1

repeat{
  # Add a random variation between -10 and 10 to the current price
  price <- price + sample(-10:10, 1)
  
  # Print the number of loop and price
  cat("The", loop, "-th price is", price, "\n")
  
  # Count the number of loop
  loop = loop +1 
  
  if (price > 95 | loop > 10) break
}

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