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

# Filter: We keep only observations with arrival delay greater than 10 hours:
filter1 <- hflights2 %>% filter(ArrDelay > 600)
View(delayed)

# Filter: All flights flown by one of AA, FL, or XE:
filter2 <- hflights2 %>% filter(UniqueCarrier %in% c("AA", "FL", "XE"))
table(filter2$UniqueCarrier)

# All flights where taxiing took longer than flying
filter3 <- hflights2 %>% filter(TaxiIn + TaxiOut > AirTime)
filter3[,c("TaxiIn", "TaxiOut", "AirTime")]

# Combining tests using boolean operators
# all flights that departed before 5am or arrived after 10pm.
filter4 <- filter(hflights2, DepTime < 500 | ArrTime > 2200)
filter4[,1:7]

# all flights that departed late but arrived ahead of schedule
filter5 <- filter(hflights2, DepDelay > 0, ArrDelay < 0)
filter5[,11:15]

# all cancelled weekend flights
filter6 <- filter(hflights2, DayOfWeek %in% c(6,7), Cancelled == 1)
filter6[,c(1:4,18:21)]

# all flights that were cancelled after being delayed
filter7 <- filter(hflights2, Cancelled == 1, DepDelay > 0)
filter7[,c(1:4,13,19)]

# filter, select, and arrnage
hflights2 %>% filter(ArrDelay > 600) %>% 
  select(Year, Month,DayofMonth, UniqueCarrier, FlightNum, ArrDelay) %>%
  arrange(ArrDelay)

hflights2 %>% filter(ArrDelay > 600) %>% 
  select(Year, Month,DayofMonth, UniqueCarrier, FlightNum, ArrDelay) %>%
  arrange(desc(ArrDelay))

# Arrange with more than two variables
arrange1 <- arrange(hflights2, UniqueCarrier, DepDelay)
arrange1[,c(1:4,7,13)]

# Mutate example
mutate1 <- hflights2 %>% mutate(TotalTime = TaxiIn + AirTime + TaxiOut)

# Compare with the original value
mutate1 %>% select(TotalTime, ActualElapsedTime) %>% head

# Add multiple variables
mutate2 <- mutate(hflights, 
                  loss = ArrDelay - DepDelay,
                  loss_percent = (ArrDelay - DepDelay)/DepDelay * 100)
glimpse(mutate2)

# Determine the shortest and longest distance flown and save statistics to min_dist and max_dist
summarize1 <- summarize(hflights, min_dist = min(Distance), max_dist = max(Distance))
summarize1

# Determine the longest distance for diverted flights, save statistic to max_div 
summarize2 <- summarize(filter(hflights, Diverted==1), max_div = max(Distance))
summarize2

# Aggregate functions in basic R
agg1 <- filter(hflights2, !is.na(ArrDelay))
agg2 <- summarize(agg1,
                earliest = min(ArrDelay),
                average = mean(ArrDelay),
                latest = max(ArrDelay),
                sd = sd(ArrDelay))
agg2

# Additional aggregate functions provided by dplyr
agg3 <- summarise(hflights2, n_obs = n(),
                n_carrier = n_distinct(UniqueCarrier),
                n_dest = n_distinct(Dest),
                dest100 = nth(Dest, 100))
agg3


# Calculate the summarizing statistics for flights flown by American Airlines (carrier code AA)
AA <- filter(hflights2, UniqueCarrier == "AA")
agg4 <- summarise(AA, n_flights = n(),
                  n_canc = sum(Cancelled == 1),
                  p_canc = mean(Cancelled == 1) * 100,
                  avg_delay = mean(ArrDelay, na.rm = TRUE))
agg4

# The average departure and arrival delays for each day of the week
hflights2 %>% group_by(DayOfWeek) %>%
  summarise(AverageArrDelay = mean(ArrDelay, na.rm = TRUE),
            AverageDepDelay = mean(DepDelay, na.rm = TRUE))

# Note how more immediate is feels compared to basic R
AverageArrDelay <- tapply(hflights$ArrDelay, hflights$DayOfWeek, mean, na.rm = TRUE)
AverageDepDelay <- tapply(hflights$DepDelay, hflights$DayOfWeek, mean, na.rm = TRUE)
cbind(sort(unique(hflights$DayOfWeek)), AverageArrDelay, AverageDepDelay)

# We rank airline companies according to their average departure delay
hflights2 %>% filter(!is.na(DepDelay), DepDelay > 0) %>% # we keep only flights with a departure delay
  group_by(UniqueCarrier) %>%
  summarise(avg = mean(DepDelay)) %>% # average departure delay for each company
  mutate(rank = rank(avg)) %>% #
  arrange(rank)

# Note how complicate it would have been not to use the %>% operator in the previous example:
hflights2 <- group_by(filter(hflights2, !is.na(DepDelay), DepDelay > 0),
                      UniqueCarrier)
arrange(
  mutate(summarise(hflights2, avg = mean(DepDelay)),
         rank = rank(avg)
  ),
  rank
)

# Arrange the UniqueCarrier with the delay proportion and their rank
hflights2 %>%
  group_by(UniqueCarrier) %>%
  filter(!is.na(ArrDelay)) %>%
  summarise(p_delay = mean(ArrDelay > 0)) %>%
  mutate(rank = rank(p_delay)) %>%
  arrange(rank)

# Arrange the UniqueCarrier with the average arrival delay time with their rank
hflights2 %>%
  group_by(UniqueCarrier) %>%
  filter(!is.na(ArrDelay), ArrDelay > 0) %>%
  summarise(avg = mean(ArrDelay)) %>%
  mutate(rank = rank(avg)) %>%
  arrange(rank)

# Which plane (by tail number) flew out of Houston the most times? How many times?
hflights2 %>%
  group_by(TailNum) %>%
  summarise(n = n()) %>%
  filter(n == max(n))

# How many airplanes only flew to one destination from Houston?
hflights2 %>%
  group_by(TailNum) %>%
  summarise(ndest = n_distinct(Dest)) %>%
  filter(ndest == 1) %>%
  summarise(nplanes = n())

# Find the most visited destination for each carrier
hflights2 %>%
  group_by(UniqueCarrier, Dest) %>%
  summarise(n = n()) %>%
  mutate(rank = rank(desc(n))) %>%
  filter(rank == 1)

# Find the carrier that travels to each destination the most
hflights2 %>%
  group_by(Dest, UniqueCarrier) %>%
  summarise(n = n()) %>%
  mutate(rank = rank(desc(n))) %>%
  filter(rank == 1)
