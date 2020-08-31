# Part 1: Data Handling (Vector) ----------------------------------------

# Assign values to the vector A & B
A <- c(1,2,3)
B <- c(1, "A", 0.5)

# Check the mode
mode(A)
mode(B)

# Select a subset of vector
A[1]
A[2:3]
A[c(2,3)]

# Assign names
names(A)
names(A) <- c("First", "Second", "Third")

# call by index or name
A[1]
A["First"]

# Data Handling: Vector
x <- c(1,2,3,4)
x
x <- c(x[1:3], 10, x[4])
x
length(x)

c(1,2,4) + c(10,11,12,13,14)

x <- matrix(1:6, nrow=3, ncol=2)
x
x + c(1:2)

x <- c(1,2,3)
y <- c(10,20,30)

x+y
x*y
x%%y

y <- c(10,20,30,40,50)
y[c(1,3)]
y[2:3]
v <- 2:3
y[v]

y[c(1,2,1,3)]

y[-5]
y[-length(y)]

x <- 1:5
y <- 5:1
z <- 2
1:z-1
1:(z-1)

seq(from=12,to=30,by=3)
seq(from=12,to=30,by=4)
seq(from=1.1,to=2,length=10)

rep(10,5)
rep(c(10,20,30),3)
rep(1:3,3)
rep(c(10,20,30),each=3)

x <- 1:10
x > 8
any(x > 8)
any(x > 20)
all(x > 8)
all(x > 0)

x <- c(1,2,NA,4,5)
y <- c(1,2,NULL,4,5)

mean(x)
mean(x, na.rm = TRUE)

mean(y)

x <- c(10,20,NA,40,50)
x[x>20]
subset(x, x>20)
which(x>20)