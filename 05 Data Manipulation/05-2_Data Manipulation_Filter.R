install.packages("dplyr")
library(dplyr)

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