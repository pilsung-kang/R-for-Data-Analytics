install.packages("dplyr")
library(dplyr)

# Dataframes and tibbles
install.packages("hflights")
library(hflights)

# Tibble
hflights2 <- tbl_df(hflights)
hflights2
glimpse(hflights2) # to catch a glimpse

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
