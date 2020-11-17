############################################################################################
# Basic plot 4: Plot
methods("plot")

# Scatter plot
x <- 1:10
y <- x^2
plot(x,y)

# Different type of graph
par(mfrow = c(2,3))
plot(x, y, main = "default : points")
plot(x, y, type = "l", main = "lines")
plot(x, y, type = "h", main = "histogram")
plot(x, y, type = "n", main = "no plotting")
plot(x, y, type = "b", main = "both points and lines")
plot(x, y, type = "s", main = "stair steps")
dev.off()

# Different type of line
par(mfrow = c(2, 3))
plot(x, y, type = "l", lty = 0)
plot(x, y, type = "l", lty = 1)
plot(x, y, type = "l", lty = 2)
plot(x, y, type = "l", lty = 3)
plot(x, y, type = "l", lty = 4)
plot(x, y, type = "l", lty = 5)
dev.off()

# Axis setting
plot(1:5, type = "l", main = "axis", axes = FALSE, xlab = "", ylab = "")
axis(side = 1, at = 1:5, labels = LETTERS[1:5], line = 2)
axis(side = 2, tick = FALSE, col.axis = "blue")
axis(side = 3, outer = TRUE)
axis(side = 3, at = c(1, 3, 5), pos = 3, col = "blue", col.axis = "red")
axis(side = 4, lty = 2, lwd = 2)

# Points
plot(iris$Sepal.Width, iris$Sepal.Length, cex = 2, pch = 2,
     xlab = "Width", ylab = "Length", main = "iris")
points(iris$Petal.Width, iris$Petal.Length, cex = 2, pch = "+", col = "blue")

# Lines
x <- seq(from = 0, to = 2*pi, by = 0.1)
y <- sin(x)

plot(x, y)
lines(x, y, lty = 3)

# ablines()
plot(x, y)
abline(v = 3, lty = 2)  # vertical
abline(h = 0, lty = 3)  # horizontal
abline(a = -1, b = 1, col = "red")  # y = -1 + x

############################################################################################
# Basic plot 5: Strip Chart
data("airquality")
View(airquality)
str(airquality)

# Basic Strip Chart
stripchart(airquality$Ozone)
# Compare with histogram
hist(airquality$Ozone)

# Strip chart for better looking
stripchart(airquality$Ozone,
           main="Mean ozone in parts per billion at Roosevelt Island",
           xlab="Parts Per Billion", ylab="Ozone",
           method="jitter", col="blue", cex = 2, pch=1)

# Strip chart for better looking
stripchart(airquality$Ozone,
           main="Mean ozone in parts per billion at Roosevelt Island",
           xlab="Parts Per Billion", ylab="Ozone",
           method="stack", col="blue", cex = 2, pch=1)

# Multiple strip chart in a single graph
stripchart(airquality[,c(1:4)],
           main="Multiple stripchart for comparision",
           xlab="value", ylab="variable", method="jitter",
           col=c("orange","red","blue","black"), pch=c(1,2,3,4))

# Strip chart from formula
stripchart(Temp ~ Month,
           data=airquality,
           main="Different strip chart for each month",
           xlab="Months", ylab="Temperature", col = grey.colors(5),
           group.names=c("May","June","July","August","September"),
           vertical=TRUE, pch=16, method="jitter", cex = 2)

# Multiple strip charts in different graphs
par(mfcol = c(3,1))
# Temperature
stripchart(Temp ~ Month,
           data=airquality,
           main="Different strip chart for each month",
           xlab="Months", ylab="Temperature", col="black",
           group.names=c("May","June","July","August","September"),
           vertical=TRUE, pch=16, method="jitter", cex = 1.5)

# Ozone
stripchart(Ozone ~ Month,
           data=airquality,
           main="Different strip chart for each month",
           xlab="Months", ylab="Ozone", col="blue",
           group.names=c("May","June","July","August","September"),
           vertical=TRUE, pch=8, method="jitter", cex = 1.5)

# Solar.R
stripchart(Solar.R ~ Month,
           data=airquality,
           main="Different strip chart for each month",
           xlab="Months", ylab="Solar.R", col="red",
           group.names=c("May","June","July","August","September"),
           vertical=TRUE, pch=2, method="jitter", cex = 1.5)

dev.off()

############################################################################################
# Basic plot 6: pairs
pairs(iris[,1:4], pch = 19)
pairs(iris[,1:4], pch = 19, lower.panel = NULL)

# Coloring scatterplots
pairs(iris[,1:4], main = "Anderson's Iris Data -- 3 species",
      pch = 21, bg = c("red", "green3", "blue")[unclass(iris$Species)])

# Coloring scatterplots 2
pairs(airquality[,c(1:4,6)], main = "Airquality",
      pch = 21, 
      bg = c("red", "green3", "blue", "orange", "black")[airquality$Month-4])
