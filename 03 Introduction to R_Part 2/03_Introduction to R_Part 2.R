# Part 3: Conditions and Repititions --------------------------------------

# Condition
r <- 1
if (r==4) {
  printf("The valus of r is 4")
} else {
  print("The valus of r is not 4")
}

carbon <- c(10, 12, 15, 19, 20)
if (mean(carbon) > median(carbon)) {
  print ("Mean > Median")
} else {
  print ("Median <= Mean")
}

# Caution!
if (mean(carbon) > median(carbon)) {
  print ("Mean > Median")
} 
else {
  print ("Median <= Mean")
}

# ifelse example
x <- 1:10
y <- ifelse(x%%2 == 0, "even", "odd")
y

# loop
n <- c(5,10,15)

for (i in n) {
  print(i^2)
}

i <- 1
while (i <= 10) {
  i <- i+4
  print(i)
}

i <- 1
repeat {
  i <- i+4
  print(i)
  if (i > 10) break
}


# Part 4: Functions -------------------------------------------------------

# User written functions
mean.and.sd1 <- function(x) {
  av <- mean(x)
  sdev <- sd(x)
  return(c(mean=av, SD=sdev))
}

distance <- c(148, 182, 173, 166, 109, 141, 166)
mean.and.sd1(distance)

mean.and.sd2 <- function(x) {
  av <- mean(x)
  sdev <- sd(x)
  c(mean=av, SD=sdev)
  return(av)
}

distance <- c(148, 182, 173, 166, 109, 141, 166)
mean.and.sd2(distance)

mean.and.sd3 <- function(x = rnorm(10)) {
  av <- mean(x)
  sdev <- sd(x)
  c(mean=av, SD=sdev)
}

mean.and.sd3()
mean.and.sd3(distance)

# Function arguments
addTheLog <- function(first, second) {first + log(second)}
# Exact names
addTheLog(second=exp(4),first=1)
# Partially matching names
addTheLog(s=exp(4),first=1)
# Argument order
addTheLog(1,exp(4))

# Return the result with return()
oddcount <- function(x) {
  k <- 0
  print(sprintf("odd number calculator"))
  for (n in 1:x) {
    if (n %% 2 == 1) {
      cat(sprintf("%d is an odd number. \n", n))
      k <- k+1
    }
  }
  return(k)
}

oddcount(10)

# Return the result without return() but explicitly designate the object
oddcount <- function(x) {
  k <- 0
  print(sprintf("odd number calculator"))
  for (n in 1:x) {
    if (n %% 2 == 1) {
      cat(sprintf("%d is an odd number. \n", n))
      k <- k+1
    }
  }
  k
}

oddcount(10)

# Return the result without either return() or explicit designation
oddcount <- function(x) {
  k <- 0
  print(sprintf("odd number calculator"))
  for (n in 1:x) {
    if (n %% 2 == 1) {
      cat(sprintf("%d is an odd number. \n", n))
      k <- k+1
    }
  }
}

oddcount(10)

# Function example 1
findrepeats <- function(x, k) {
  n <- length(x)
  repeats <- NULL
  for (i in 1:(n-k+1)) {
    if(all(x[i:(i+k-1)] == 1)) repeats <- c(repeats, i)
  }
  return(repeats)
}

vec <- c(0,1,1,0,0,1,1,1,0,1,1)
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


# Part 5: R Graphs --------------------------------------------------------
# Graphs used in R 
data(iris)
x <- iris[,1]
y <- iris[,2]
subiris <- iris[,1:2]

# Graph polymorphism: a single graph function returns different outputs according to the argument type 
plot(x,y)
plot(subiris)
plot(iris)

# Display title, x-y axis labels 
plot(subiris, main="The comparison between length and width",
     xlab = "The length of sepal",
     ylab = "The width of sepal")

# Change the shape and color in the graph 
plot(iris[,1],iris[,2],pch=as.integer(iris[,5]))

# An example of possible colors and shapes 
plot(iris$Sepal.Length,iris$Sepal.Width,
     pch=as.integer(iris$Species),col=as.integer(iris$Species)+10)

# Examples of possible colors and shapes 
plot(0,0, xlim=c(0,13), ylim=c(0,4), type="n")
xpos <- rep((0:12)+0.5,2)
ypos <- rep(c(3,1), c(13,13))
points(xpos, ypos, cex=seq(from=1,to=3,length=26), col=1:26, pch=0:25)
text(xpos, ypos, labels = paste(0:25), cex=seq(from=0.1,to=1,length=26))

# Conditional graph 
coplot(iris[,1]~iris[,2] | iris[,5])

# Bar graph
data(airquality)
heights <- tapply(airquality$Temp, airquality$Month, mean)
barplot(heights)
barplot(heights, main="Mean Temp. by Month",
        names.arg = c("May", "Jun", "Jul", "Aug", "Sep"),
        ylab = "Temp (deg.F)")

# Bar graph with other options 
rel.hts <- (heights-min(heights))/(max(heights)-min(heights))
grays <- gray(1-rel.hts)
barplot(heights, col=grays, ylim=c(50,90), xpd=FALSE,
        main="Mean Temp. by Month",
        names.arg = c("May", "Jun", "Jul", "Aug", "Sep"),
        ylab = "Temp (deg.F)")

# Histogram 
samp <- rgamma(500,2,2)
hist(samp, 20, prob=T)
lines(density(samp))

# Save the plot as a png file 
png("Hist_dist.png")
hist(samp, 20, prob=T)
lines(density(samp))
dev.off()

# Save the plot as a pdf file 
pdf("Hist_dist.pdf")
hist(samp, 20, prob=T)
lines(density(samp))
dev.off()

# ggplot2 package for more various graphs 
install.packages("ggplot2")
library(ggplot2) 
data(mtcars)

# Convert the data type into factor 
mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5), labels=c("3gears","4gears","5gears")) 
mtcars$am <- factor(mtcars$am,levels=c(0,1), labels=c("Automatic","Manual")) 
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8), labels=c("4cyl","6cyl","8cyl")) 

# Estimate the kernel density function with regard to mpg
# Use different colors with regard to the number of gears
qplot(mpg, data=mtcars, geom="density", fill=gear, 
      alpha=I(.5), main="Distribution of Gas Milage", 
      xlab="Miles Per Gallon", ylab="Density")

# Scatter plot for mpg and hp with regard to gear-cylinder combinations
# The variable "am" is expressed by the shape and color
qplot(hp, mpg, data=mtcars, shape=am, color=am, 
      facets=gear~cyl, size=I(3),
      xlab="Horsepower", ylab="Miles per Gallon")

# Show the regression line between wt and mpg with regard to the number of cyliners 
p <- ggplot(mtcars, aes(y=mpg, x=wt, colour=factor(cyl))) 
p <- p + ggtitle("Regression of MPG on Weight") 
p <- p + stat_smooth(method=lm, aes(fill = factor(cyl))) + geom_point()
p

# Bol plot of mpg with regard to number of gears 
# Display actual values with dots
qplot(gear, mpg, data=mtcars, geom=c("boxplot", "jitter"), 
      fill=gear, main="Mileage by Gear Number",
      xlab="", ylab="Miles per Gallon")

