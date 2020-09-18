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
