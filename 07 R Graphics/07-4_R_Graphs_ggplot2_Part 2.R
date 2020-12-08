install.packages("ggplot2")
library(ggplot2)

# (Note) All the scripts below are taken from
# http://r-statistics.co/Complete-Ggplot2-Tutorial-Part2-Customizing-Theme-With-R-Code.html
# Part 2: Customizing the look and feel

# Setup
options(scipen=999)
data("midwest", package = "ggplot2")
theme_set(theme_bw())
# midwest <- read.csv("http://goo.gl/G1K41K")  # bkup data source

# Add plot components --------------------------------
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", x="Area", caption="Source: midwest")

# Call plot ------------------------------------------
plot(gg)

# 1. Addiing plot and axis title
# Base Plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", x="Area", caption="Source: midwest")
plot(gg)

# Modify theme components -------------------------------------------
gg + theme(plot.title=element_text(size=20, 
                                   face="bold", 
                                   color="tomato",
                                   hjust=0.5,
                                   lineheight=1.2),  # title
           plot.subtitle=element_text(size=15, 
                                      face="bold",
                                      hjust=0.5),  # subtitle
           plot.caption=element_text(size=15),  # caption
           axis.title.x=element_text(vjust=10,  
                                     size=15),  # X axis title
           axis.title.y=element_text(size=15),  # Y axis title
           axis.text.x=element_text(size=10, 
                                    angle = 30,
                                    vjust=.5),  # X axis text
           axis.text.y=element_text(size=10))  # Y axis text

# 2. Modifying legend
# How to change the legend title
# Method 1: using labs()
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", 
             x="Area", caption="Source: midwest")
plot(gg)

gg + labs(color="State", size="Density")  # modify legend title

# Method 2: using guides()
# Base Plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", 
             x="Area", caption="Source: midwest")
plot(gg)

gg + guides(color=guide_legend("State"), size=guide_legend("Density"))  

# Method 3: Using scale_aesthetic_vartype() format
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", 
             x="Area", caption="Source: midwest")
plot(gg)

# Modify Legend
gg + scale_color_discrete(name="State") + 
        scale_size_continuous(name = "Density", guide=FALSE) # turn off legend for size

# How to Change Legend Labels and Point Colors for Categories
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", 
             x="Area", caption="Source: midwest")
plot(gg)

gg + scale_color_manual(name="State", 
                        labels = c("Illinois", 
                                   "Indiana", 
                                   "Michigan", 
                                   "Ohio", 
                                   "Wisconsin"), 
                        values = c("IL"="blue", 
                                   "IN"="red", 
                                   "MI"="green", 
                                   "OH"="brown", 
                                   "WI"="orange"))

# Change the order of legend
# Base Plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", 
             x="Area", caption="Source: midwest")
plot(gg)

gg + guides(colour = guide_legend(order = 2),
            size = guide_legend(order = 1))

# Style the legend title, text, and key
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", 
             x="Area", caption="Source: midwest")
plot(gg)

gg + theme(legend.title = element_text(size=12, color = "firebrick"), 
           legend.text = element_text(size=10),
           legend.key=element_rect(fill='springgreen')) + 
        guides(colour = guide_legend(override.aes = list(size=2, stroke=1.5))) 

# Remove the legend and change legend positions
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", 
             x="Area", caption="Source: midwest")
plot(gg)

# No legend --------------------------------------------------
gg + theme(legend.position="None") + labs(subtitle="No Legend")

# Legend to the left -----------------------------------------
gg + theme(legend.position="left") + labs(subtitle="Legend on the Left")

# legend at the bottom and horizontal ------------------------
gg + theme(legend.position="bottom", legend.box = "horizontal") + 
        labs(subtitle="Legend at Bottom")

# legend at bottom-right, inside the plot --------------------
gg + theme(legend.title = element_text(size=12, color = "salmon", face="bold"),
           legend.justification=c(1,0), 
           legend.position=c(0.95, 0.05),  
           legend.background = element_blank(),
           legend.key = element_blank()) + 
        labs(subtitle="Legend: Bottom-Right Inside the Plot")

# legend at top-left, inside the plot -------------------------
gg + theme(legend.title = element_text(size=12, color = "salmon", face="bold"),
           legend.justification=c(0,1), 
           legend.position=c(0.05, 0.95),
           legend.background = element_blank(),
           legend.key = element_blank()) + 
        labs(subtitle="Legend: Top-Left Inside the Plot")

# 3. Adding text, label, and annotation
# Add text and label around the points
# Filter required rows.
midwest_sub <- midwest[midwest$poptotal > 300000, ]
midwest_sub$large_county <- ifelse(midwest_sub$poptotal > 300000, midwest_sub$county, "")

# Base Plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", x="Area", caption="Source: midwest")
plot(gg)

# Plot text and label ------------------------------------------------------
gg + geom_text(aes(label=large_county), size=3, data=midwest_sub) + 
        labs(subtitle="With ggplot2::geom_text") + 
        theme(legend.position = "None")

gg + geom_label(aes(label=large_county), size=3, data=midwest_sub, alpha=0.25) + 
        labs(subtitle="With ggplot2::geom_label") + 
        theme(legend.position = "None")

# Plot text and label that REPELS eachother (using ggrepel pkg) ------------
install.packages("ggrepel")
library(ggrepel)
gg + geom_text_repel(aes(label=large_county), size=3, data=midwest_sub) + 
        labs(subtitle="With ggrepel::geom_text_repel") + 
        theme(legend.position = "None")

gg + geom_label_repel(aes(label=large_county), size=3, data=midwest_sub) + 
        labs(subtitle="With ggrepel::geom_label_repel") + 
        theme(legend.position = "None")

# Add Annotations anywhere inside plot
# Base Plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", x="Area", caption="Source: midwest")
plot(gg)

# Define and add annotation -------------------------------------
library(grid)
my_text <- "This text is at x=0.7 and y=0.8!"
my_grob = grid.text(my_text, x=0.7,  y=0.8, gp=gpar(col="firebrick", fontsize=14, fontface="bold"))
gg + annotation_custom(my_grob)

# 4. Flipping and Reversing X and Y axis
# How to flip the X and Y axis?
# Just add coord_flip()
# Base Plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
        geom_point(aes(col=state, size=popdensity)) + 
        geom_smooth(method="loess", se=F) + xlim(c(0, 0.1)) + ylim(c(0, 500000)) + 
        labs(title="Area Vs Population", y="Population", x="Area", caption="Source: midwest", subtitle="X and Y axis Flipped") + theme(legend.position = "None")
plot(gg)

# Flip the X and Y axis ------------------------------
gg + coord_flip()

# Reverse the X and Y Axis ---------------------------
gg + scale_x_reverse() + scale_y_reverse()

# 5. Faceting: Draw multiple plots within one figure
data(mpg, package="ggplot2")  # load data
# mpg <- read.csv("http://goo.gl/uEeRGu")  # alt data source

g <- ggplot(mpg, aes(x=displ, y=hwy)) + 
        geom_point() + 
        labs(title="hwy vs displ", caption = "Source: mpg") +
        geom_smooth(method="lm", se=FALSE) + 
        theme_bw()  # apply bw theme
plot(g)

# Facet Wrap
# Base Plot
g <- ggplot(mpg, aes(x=displ, y=hwy)) + 
        geom_point() + 
        geom_smooth(method="lm", se=FALSE) + 
        theme_bw()  # apply bw theme
plot(g)

# Facet wrap with common scales
g + facet_wrap( ~ class, nrow=3) + 
        labs(title="hwy vs displ", caption = "Source: mpg", subtitle="Ggplot2 - Faceting - Multiple plots in one figure")  # Shared scales

# Facet wrap with free scales
g + facet_wrap( ~ class, scales = "free") + 
        labs(title="hwy vs displ", caption = "Source: mpg", subtitle="Ggplot2 - Faceting - Multiple plots in one figure with free scales")  # Scales free

# Facet_grid()
# Base Plot
g <- ggplot(mpg, aes(x=displ, y=hwy)) + 
        geom_point() + 
        labs(title="hwy vs displ", caption = "Source: mpg", subtitle="Ggplot2 - Faceting - Multiple plots in one figure") +
        geom_smooth(method="lm", se=FALSE) + 
        theme_bw()  # apply bw theme
plot(g)

# Add Facet Grid
g1 <- g + facet_grid(manufacturer ~ class)  # manufacturer in rows and class in columns
plot(g1)

# Base Plot
g <- ggplot(mpg, aes(x=displ, y=hwy)) + 
        geom_point() + 
        geom_smooth(method="lm", se=FALSE) + 
        labs(title="hwy vs displ", caption = "Source: mpg", subtitle="Ggplot2 - Facet Grid - Multiple plots in one figure") +
        theme_bw()  # apply bw theme
plot(g)

# Add Facet Grid
g2 <- g + facet_grid(cyl ~ class)  # cyl in rows and class in columns.
plot(g2)

# Draw Multiple plots in same figure.
install.packages("gridExtra")
library(gridExtra)
gridExtra::grid.arrange(g1, g2, ncol=2)

# 6. Modifying plot background, major and minor axis
# Base Plot
g <- ggplot(mpg, aes(x=displ, y=hwy)) + 
        geom_point() + 
        geom_smooth(method="lm", se=FALSE) + 
        theme_bw()  # apply bw theme
plot(g)

# Change Plot Background elements -----------------------------------
g + theme(panel.background = element_rect(fill = 'khaki'),
          panel.grid.major = element_line(colour = "burlywood", size=1.5),
          panel.grid.minor = element_line(colour = "tomato", 
                                          size=.25, 
                                          linetype = "dashed"),
          panel.border = element_blank(),
          axis.line.x = element_line(colour = "darkorange", 
                                     size=1.5, 
                                     lineend = "butt"),
          axis.line.y = element_line(colour = "darkorange", 
                                     size=1.5)) +
        labs(title="Modified Background", 
             subtitle="How to Change Major and Minor grid, Axis Lines, No Border")

# Change Plot Margins -----------------------------------------------
g + theme(plot.background=element_rect(fill="salmon"), 
          plot.margin = unit(c(2, 2, 1, 1), "cm")) +  # top, right, bottom, left
        labs(title="Modified Background", subtitle="How to Change Plot Margin")  

# How to Remove Major and Minor Grid, Change Border, Axis Title, Text and Ticks
# Base Plot
g <- ggplot(mpg, aes(x=displ, y=hwy)) + 
        geom_point() + 
        geom_smooth(method="lm", se=FALSE) + 
        theme_bw()  # apply bw theme

g + theme(panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(), 
          panel.border = element_blank(),
          axis.title = element_blank(), 
          axis.text = element_blank(),
          axis.ticks = element_blank()) +
        labs(title="Modified Background", subtitle="How to remove major and minor axis grid, border, axis title, text and ticks") 

# Add an image in background
install.packages("grid")
library(grid)
install.packages("magick")
library(magick)

image_url <- "https://www.r-project.org/Rlogo.png"
pic <- image_read(image_url)
print(pic)
g_pic <- rasterGrob(pic, interpolate=TRUE)

# Base Plot
g <- ggplot(mpg, aes(x=displ, y=hwy)) + 
        geom_point() + 
        geom_smooth(method="lm", se=FALSE) + 
        theme_bw()  # apply bw theme
plot(g)

g + theme(panel.grid.major = element_blank(), 
          panel.grid.minor = element_blank(), 
          plot.title = element_text(size = rel(1.5), face = "bold"),
          axis.ticks = element_blank()) + 
        annotation_custom(g_pic, xmin=5, xmax=7, ymin=30, ymax=45)
