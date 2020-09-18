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
  
  if (price > 110 | loop > 10) break
}

