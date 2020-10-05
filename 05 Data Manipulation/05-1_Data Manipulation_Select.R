install.packages("dplyr")
library(dplyr)

# load data "mtcars"
data(mtcars)
View(mtcars)
head(mtcars)

# Add the model name in a new column
mtcars$model <- rownames(mtcars)

# Question:
# What are the car models with fewer than 6 cylinders and a consumption less than 20 miles/gallon?
index <- which(mtcars$cyl <= 6 & mtcars$mpg < 20)
mtcars$model[index]

# Here we can do the same thing with dplyr
x <- filter(mtcars, cyl <= 6, mpg < 20)
x
select(x, model)

# Do the same thing in one line
select( filter(mtcars, cyl <= 6, mpg < 20), model)

# Do the same thing in one line using pipeline
mtcars %>% filter(cyl <= 6, mpg < 20) %>% select(model)

# Dataframes and tibbles
install.packages("hflights")
library(hflights)

# Dataframe
str(hflights)
dim(hflights)
hflights # Not recommended
head(hflights) # Recommended

# Tibble
hflights2 <- tbl_df(hflights)
hflights2
glimpse(hflights2) # to catch a glimpse

# Select()
select(hflights2, Origin, Dest)
# Note that select() does not change the data frame it is called on:
dim(hflights2)
orig_dest <- select(hflights2, Origin, Dest)
dim(orig_dest)

# Select(): drop operator
colnames(hflights2)
drop_hflights2 <- select(hflights2, -c("Year", "Month", "UniqueCarrier"))
drop_hflights2

# Helper function
# Select(): select variable names based on patterns
colnames(hflights2)

# Let's select the variables starting with "D"
select(hflights2, starts_with("D"))

# Let's select the variables ending with "e"
select(hflights2, ends_with("e"))

# Let's select the variables ending with "Time"
select(hflights2, ends_with("Time"))

# Let's select the variables containing "n"
select(hflights2, contains("n"))

# Let's select the variables with certain names if they exist
select(hflights2, FlightNum, Distance, Cancelled, Pilsung)

# Let's select the variables with certain names if they exist
select(hflights2, one_of(c("FlightNum", "Distance", "Cancelled", "Pilsung")))

# Pipe operator %>%
# Without pipe operator
nrow(unique(select(hflights2, Dest)))

# With pipe operator
hflights2 %>% select(Dest) %>% unique %>% nrow()

# With pipe operator and n_distinct() function
hflights2 %>% select(Dest) %>% n_distinct()

# Placeholder (.) example
ratio <- function(x,y) x/y
1 %>% ratio(2)
2 %>% ratio(1, .)