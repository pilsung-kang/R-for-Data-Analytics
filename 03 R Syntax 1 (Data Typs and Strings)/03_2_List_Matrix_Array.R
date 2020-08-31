# Part 2-1: Data Handling (List)

# Example of a list
listA <- list(1, 2, "a")
print(listA)
listA[[1]]
listA[c(1,2)]
names(listA)
names(listA) <- c("First", "Second", "Third")

listA[["Third"]]
listA$Third

# Data Handling: List
A <- list(name="Kang", salary = 10000, union = TRUE)
A
A$name

B <- list("Kang", 10000, TRUE)
B
B[[1]]

C <- vector(mode="list")
C[["name"]] <- "Kang"
C[["salary"]] <- 10000
C[["union"]] <- TRUE
C

C$name
C[["name"]]
C[[1]]

C1 <- C[[1]]
class(C1)
C1

C2 <- C[1]
class(C2)
C2

C$office <- "frontier"
C

C$salary <- NULL
C

tmplist <- list(a = list(1:5, c("a","b","c")), b = "Z", c = NA)
tmplist
unlist(tmplist)
unlist(tmplist, use.names = FALSE)

A <- list(1:3,25:29)
A
lapply(A,median)
sapply(A,median)


# Part 2-2: Data Handling (Matrix) 

# Example of a matrix
A <- 1:6
dim(A)
print(A)

dim(A) <- c(2,3)
print(A)

B <- list(1,2,3,4,5,6)
print(B)
dim(B)
dim(B) <- c(2,3)
print(B)

D <- 1:12
dim(D) <- c(2,3,2)
print(D)

# Part 2-3: Data Handling (Matrix & Array)
A = matrix(1:15, nrow=5, ncol=3)
A

B = matrix(1:15, nrow=5, byrow = T)
B

C = matrix(nrow=2,ncol=2)
C[1,1] = 1
C[1,2] = 2
C[2,1] = 3
C[2,2] = 4
C

A = matrix(1:4, nrow=2, ncol=2)
B = matrix(seq(from=2,to=8,by=2), nrow=2, ncol=2)
A
B

A*B # Element-wise matrix multiplication
A %*% B # Matrix multiplication
A*3 # Matrix*Constant
A+B # Matrix Addition

C = matrix(1:15, nrow=5, ncol=3)
C
C[3,2]
C[2,]
C[,3]
C[2:4,2:3]
C[-1,]

C[1,] <- c(10, 11, 12)
C

A <- matrix(c(1:6), nrow=3, ncol=2)
A
A[A[,2]>=5,]

which(A>3)

A <- matrix(c(1:6), nrow=3, ncol=2)
apply(A,1,mean)
apply(A,2,mean)

A <- matrix(c(1:6), nrow=3, ncol=2)
B <- matrix(c(11:16), nrow=3, ncol=2)

A
B

rbind(A,B)
cbind(A,B)

cbind(A[,1],B[,2])

A <- matrix(c(1:6), nrow=3, ncol=2)
colnames(A)
rownames(A)

colnames(A) <- c("1st","2nd")
colnames(A)

rownames(A) <- c("First","Second","Third")
rownames(A)

A[,"1st",drop=FALSE]

A <- matrix(c(1:15), nrow=5, ncol=3)
B <- matrix(c(11:25), nrow=5, ncol=3)
A
B

C <- array(data=c(A,B),dim=c(3,2,2))
C