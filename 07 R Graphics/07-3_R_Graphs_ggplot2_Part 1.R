###########################################################
# Installation
# The easiest way to get ggplot2 is to install the whole tidyverse:
install.packages("tidyverse")

# Alternatively, install just ggplot2:
install.packages("ggplot2")

# Or the development version from GitHub:
# install.packages("devtools")
devtools::install_github("tidyverse/ggplot2")
#############################################################

# (Note) All the scripts below are taken from
# http://r-statistics.co/Complete-Ggplot2-Tutorial-Part1-With-R-Code.html

# 1. Understanding the ggplot syntax
# Setup
options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2) 
data("midwest", package = "ggplot2")  # load the data
# midwest <- read.csv("http://goo.gl/G1K41K") # alt source 
View(midwest)

# Initialize ggplot
ggplot(midwest, aes(x=area, y=poptotal))  # area and poptotal are columns in 'midwest'

# 2. How to make a simple scatterplot
ggplot(midwest, aes(x=area, y=poptotal)) + geom_point()

g <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point() + 
        geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands
plot(g)

# 3. Adjusting the X and Y axis limits
# Method 1: by deleting the points outside the range
g <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point() + 
        geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands

# Delete the points outside the limits
g + xlim(c(0, 0.1)) + ylim(c(0, 1000000))   # deletes points

# Method 2: Zooming in
g <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point() + 
        geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands

# Zoom in without deleting the points outside the limits. 
# As a result, the line of best fit is the same as the original plot.
g1 <- g + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))  # zooms in
plot(g1)

# How to change the title and axis labels
g <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point() + 
        geom_smooth(method="lm")

g1 <- g + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))

# Add Title and Labels
g1 + labs(title="Area Vs Population", subtitle="From midwest dataset", 
          y="Population", x="Area", caption="Midwest Demographics")
# or
g1 + ggtitle("Area Vs Population", subtitle="From midwest dataset") + 
        xlab("Area") + ylab("Population")

# Full function call
ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point() + 
        geom_smooth(method="lm") + 
        coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", 
             y="Population", x="Area", caption="Midwest Demographics")

# How to change the color and size of points
ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(col="steelblue", size=3) +   # Set static color and size for points
        geom_smooth(method="lm", col="firebrick") +  # change the color of line
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", 
             y="Population", x="Area", caption="Midwest Demographics")

# How to change the color to reflect categories in another column?
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
        geom_smooth(method="lm", col="firebrick", size=2) + 
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", 
             y="Population", x="Area", caption="Midwest Demographics")
plot(gg)

gg + theme(legend.position="None")  # remove legend

gg + scale_colour_brewer(palette = "Set1")  # change color palette

library(RColorBrewer)
head(brewer.pal.info, 10)  # show 10 palettes

# How to change the X axis texts and ticks location
# Step 1: Set the breaks
# Base plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
        geom_smooth(method="lm", col="firebrick", size=2) + 
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", 
             y="Population", x="Area", caption="Midwest Demographics")
gg

# Change breaks
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01))

# Step 2: Change the labels
# Change breaks + label
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01), labels = letters[1:11])

# Reverse X Axis Scale
gg <- ggplot(midwest, aes(area, poptotal)) + 
        geom_point(aes(col=state), size=3) + 
        geom_smooth(method="lm", col="firebrick", size=2) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", 
             y="Population", x="Area", caption="Midwest Demographics") +
        scale_x_reverse()
 
gg + coord_cartesian(xlim=c(0.1, 0), ylim=c(0, 1000000))

# How to write customized texts for axis labels, by formatting the original value?
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
        geom_smooth(method="lm", col="firebrick", size=2) + 
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", 
             y="Population", x="Area", caption="Midwest Demographics")

# Change Axis Texts
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01), 
                        labels = sprintf("%1.2f%%", seq(0, 0.1, 0.01))) + 
        scale_y_continuous(breaks=seq(0, 1000000, 200000), 
                           labels = function(x){paste0(x/1000, 'K')})

# How to customize the entire theme in one shot using pre-built themes?
# Base plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
        geom_smooth(method="lm", col="firebrick", size=2) + 
        coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
        labs(title="Area Vs Population", subtitle="From midwest dataset", 
             y="Population", x="Area", caption="Midwest Demographics")

gg <- gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01))

# method 1: Using theme_set()
theme_set(theme_classic())
gg

# method 2: Adding theme Layer itself.
gg + theme_bw() + labs(subtitle="BW Theme")
gg + theme_classic() + labs(subtitle="Classic Theme")

