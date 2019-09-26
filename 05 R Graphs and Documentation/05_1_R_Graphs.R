# Part 5: R Graphs --------------------------------------------------------
# Polymorphism of R graph functions
data(iris)
x <- iris[,1]
y <- iris[,2]
subiris <- iris[,1:2]

# Same function with different input arguments
plot(x,y)
plot(subiris)
plot(iris)

# Add title and x,y labels
plot(subiris, main="The comparison between length and width",
     xlab = "The length of sepal",
     ylab = "The width of sepal")

# Scatter plot with different shapes for different classes
plot(iris[,1],iris[,2],pch=as.integer(iris[,5]))

# Scatter plot with different shapes & colors for different classes
plot(iris$Sepal.Length,iris$Sepal.Width,
     pch=as.integer(iris$Species),col=as.integer(iris$Species)+1)

# Predefined shapes and colors
plot(0,0, xlim=c(0,13), ylim=c(0,4), type="n")
xpos <- rep((0:12)+0.5,2)
ypos <- rep(c(3,1), c(13,13))
points(xpos, ypos, cex=seq(from=1,to=3,length=26), col=1:26, pch=0:25)
text(xpos, ypos, labels = paste(0:25), cex=seq(from=0.1,to=1,length=26))

# Conditional plot
coplot(iris[,1]~iris[,2] | iris[,5])

# Histogram
data(airquality)
head(airquality)

heights <- tapply(airquality$Temp, airquality$Month, mean)
barplot(heights)
barplot(heights, main="Mean Temp. by Month",
        names.arg = c("May", "Jun", "Jul", "Aug", "Sep"),
        ylab = "Temp (deg.F)")

# Histogram with more advanced options
rel.hts <- (heights-min(heights))/(max(heights)-min(heights))
grays <- gray(1-rel.hts)
barplot(heights, col=grays, ylim=c(50,90), xpd=FALSE,
        main="Mean Temp. by Month",
        names.arg = c("May", "Jun", "Jul", "Aug", "Sep"),
        ylab = "Temp (deg.F)")

# Histogram with the estimated distribution
samp <- rgamma(500,2,2)
hist(samp, 20, prob=T)
lines(density(samp))

# Save the plot as a png format
png("Hist_dist.png")
hist(samp, 20, prob=T)
lines(density(samp))
dev.off()

# Save the plot as a pdf format
pdf("Hist_dist.pdf")
hist(samp, 20, prob=T)
lines(density(samp))
dev.off()

# ggplot2: make r graphs more beautiful and informative
install.packages("ggplot2")
library(ggplot2) 

# Load a sample dataset
data("mpg")
head(mpg)
str(mpg)

# Check the number of rows and columns of the dataset
nrow(mpg)
ncol(mpg)
# Column names
colnames(mpg)

# qplot: function for quick and simple plot: Bar plot for manufacturer
table(mpg$manufacturer)
qplot(manufacturer, data=mpg, geom="bar", fill=manufacturer)

# qplot: function for quick and simple plot: Histogram for displacement
summary(mpg$displ)
qplot(displ, data=mpg, geom="histogram", bin=20)

# Same graph with qplot( ) and ggplot( )
qplot(displ, hwy, data=mpg, geom="point", color='red')
ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(color='blue')

# Looking at the data separately for each class
ggplot(mpg, aes(x = displ, y = hwy, color=class)) + geom_point()

# Add another information using the size of points
ggplot(mpg, aes(x = displ, y = hwy, colour = class)) + 
        geom_point(aes(size = factor(cyl)))

# Separate graphs for each vehicle class
ggplot(data = mpg) + 
        geom_point(mapping = aes(x = displ, y = hwy, color=class)) +
        facet_wrap(~ class, nrow = 2)

# Creating facets on the basis of two variables : number of cylinders and type of drive
ggplot(data = mpg) + 
        geom_point(mapping = aes(x = displ, y = hwy, color=drv)) +
        facet_grid(drv ~ cyl)

# Continuous + categorical
p <- ggplot(mpg, aes(factor(cyl), hwy))
p + geom_point(size=4)  # Overlaid dots
p + geom_point(size=4, position="jitter")  # Jittered dots
p + geom_point(size=4, position="jitter", alpha=.2)  # Transparent dots

# Violin plots
p3 <- ggplot(mpg, aes(x=factor(cyl), y=hwy, fill=factor(cyl)))
p3 + geom_violin(scale = "width")
# Add jittered dots for fun
p3 + geom_violin(scale = "width") + geom_point(size=2, position="jitter")

# Estimating a smooth curve for the relationship between displacement and highway mileage:
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) + geom_smooth(mapping = aes(x = displ, y = hwy), level=0.99)

# Separate curve for each type of drive:
ggplot(data = mpg) + 
        geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color=drv))

# Overlaying a smooth curve on top of scatter plot:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
        geom_point(mapping=aes(color=class)) +
        geom_smooth()

# Grouping data by drive and then drawing scatter plot with estimated curve for each group:
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
        geom_point() + 
        geom_smooth(se = FALSE)
