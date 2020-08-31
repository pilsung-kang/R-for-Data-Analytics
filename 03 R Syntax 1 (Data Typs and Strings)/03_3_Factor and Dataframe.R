# Part 3-1: Data Handling (Factor)

# Example of a factor
A <- c("Cho","Kim","Kang")
B <- as.factor(A)

print(A)
print(B)

mode(A)
mode(B)

A[1]+A[2]
B[1]+B[2]

# Data Handling: Factor
x <- c(5,12,13,12)
xf <- factor(x)
xf

str(xf)
unclass(xf)

length(xf)

xff <- factor(x, levels=c(5,12,13,88))
xff
xff[2] <- 88
xff

xff[2] <- 20
xff

ages <- c(25,26,55,37,21,42)
affils <- c("R","D","D","R","U","D")
tapply(ages, affils, mean)

gender <- c("M", "M", "F", "M", "F", "F")
age <- c(47,59,21,32,33,24)
income <- c(55000,88000,32450,76500,123000,45650)
tmp <- data.frame(gender, age, income)

tmp$over25 <- ifelse(tmp$age>25,1,0)
tmp
tapply(tmp$income, list(tmp$gender, tmp$over25), mean)

split(tmp$income, list(tmp$gender, tmp$over25))

table(tmp$gender, tmp$over25)


# Part 3-2: Data Handling (DataFrame)

# Example of data frame
A <- c(1,2,3)
B <- c("a","b","c")
C <- data.frame(A,B)
C
C[[1]]
C[[2]]
C[1,2]
C$B[2]

C <- data.frame(A,B, stringsAsFactors=FALSE)
C
C[[1]]
C[[2]]
C[1,2]
C$B[2]

kids <- c("Jack", "Jill")
ages <- c(12,10)
d <- data.frame(kids, ages, stringsAsFactors=FALSE)
d

d[[1]]
class(d[[1]])

d$kids
class(d$kids)

d[,1]
class(d[,1])

d[1]
class(d[1])

Exam <-read.csv("Exam.csv", header = TRUE)
Exam

Exam[2:5,]
Exam[2:5,2]
Exam[2:5,2, drop=FALSE]

Exam[Exam$Exam1 > 3,]

dfA <- rbind(d,list("Laura",19))
kids <- c("Alice","Jill", "Laura")
state <- c("MA", "NY", "CA")
dfB <- data.frame(kids, state, stringsAsFactors=FALSE)

merge(dfA, dfB) # default: inner join
merge(dfA, dfB, all = TRUE) # outer join
merge(dfA, dfB, all.x = TRUE) # left join
merge(dfA, dfB, all.y = TRUE) # right join

firstname <- c("Alice","Jill", "Laura")
state <- c("MA", "NY", "CA")
dfC <- data.frame(firstname, state, stringsAsFactors=FALSE)
dfC

merge(dfA, dfC, by.x="kids", by.y="firstname")