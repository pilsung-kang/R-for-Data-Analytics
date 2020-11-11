# R Graphs: Basic --------------------------------------------------------
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
points(xpos, ypos, cex=seq(from=1,to=5,length=26), col=1:26, pch=0:25)
text(xpos, ypos, labels = paste(0:25), cex=seq(from=0.1,to=2,length=26))

############################################################################################
# Basic plot 1: bar plot
View(longley)
barplot(GNP ~ Year, data = longley)
barplot(cbind(Employed, Unemployed) ~ Year, data = longley)

data(Titanic)
View(Titanic)
summary(d.Titanic <- as.data.frame(Titanic))

barplot(Freq ~ Class + Survived, data = d.Titanic,
        subset = Age == "Adult" & Sex == "Male",
        main = "barplot(Freq ~ Class + Survived, *)", ylab = "# {passengers}", legend = TRUE)

# Corresponding table :
(xt <- xtabs(Freq ~ Survived + Class + Sex, d.Titanic, subset = Age=="Adult"))
# Alternatively, a mosaic plot :
mosaicplot(xt[,,"Male"], main = "mosaicplot(Freq ~ Class + Survived, *)", color=TRUE)

# Coloring bar charts
require(grDevices) # for colours
tN <- table(Ni <- stats::rpois(100, lambda = 5))
r <- barplot(tN, col = rainbow(20))
#- type = "h" plotting *is* 'bar'plot
lines(r, tN, type = "h", col = "red", lwd = 2)

# Control the space between bars
barplot(tN, space = 1.5, axisnames = FALSE,
        sub = "barplot(..., space= 1.5, axisnames = FALSE)")

# VADeaths dataset
View(VADeaths)
barplot(VADeaths)

# Border color
barplot(VADeaths, border = "blue") 
bar_VA <- barplot(VADeaths, border = "blue") 
tot <- colMeans(VADeaths)
text(bar_VA, tot + 3, format(tot), xpd = TRUE, col = "red")

barplot(VADeaths, beside = TRUE,
        col = c("lightblue", "mistyrose", "lightcyan",
                "lavender", "cornsilk"),
        legend = rownames(VADeaths), ylim = c(0, 100))
title(main = "Death Rates in Virginia", font.main = 4)

reverse_VA <- t(VADeaths)[, 5:1]
mybarcol <- "gray20"
barplot(reverse_VA, beside = TRUE,
      col = c("lightblue", "mistyrose",
              "lightcyan", "lavender"),
      legend = colnames(VADeaths), ylim = c(0,100),
      main = "Death Rates in Virginia", font.main = 4,
      sub = "Faked upper 2*sigma error bars", col.sub = mybarcol,
      args.legend = list(x = "topleft"), # option
      cex.names = 1.5)

# Log scales
barplot(tN, col = heat.colors(12), log = "y")
barplot(tN, col = gray.colors(20), log = "xy")

############################################################################################
# Basic plot 3: dotchart
vectorToPlot <- c(1:6)
names(vectorToPlot) <- c(LETTERS[1:6])
dotchart(vectorToPlot, cex = 1.5)

myGroup <- factor(c("group1","group3","group2","group1","group3","group2"))
dotchart(vectorToPlot, groups = myGroup)
dotchart(vectorToPlot,
         gcolor = "red", groups = myGroup, 
         gdata = c(median(vectorToPlot[myGroup == "group1"]),
                   median(vectorToPlot[myGroup == "group2"]),
                   median(vectorToPlot[myGroup == "group3"])),
         cex = 1.5,
         main = "Groups of Things", xlab = "Things")

# dotplot for matrix ----
View(WorldPhones)
str(WorldPhones) # worldphones is a matrix - not a dataframe

dotchart(WorldPhones) # works, but it's messy

dotchart(WorldPhones, gcolor = "Blue", cex = 1,
         gdata = colMeans(WorldPhones), gpch = 15,
         main = "World Phones by Country")

############################################################################################
# Basic plot 4: histogram
View(islands)
hist(islands)
hist(islands, col = "blue", labels = TRUE)
hist(sqrt(islands), breaks = 12, col = "lightblue", border = "red")

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

