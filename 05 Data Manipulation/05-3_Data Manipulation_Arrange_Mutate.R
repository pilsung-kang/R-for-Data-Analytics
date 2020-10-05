install.packages("dplyr")
library(dplyr)

# Dataframes and tibbles
install.packages("hflights")
library(hflights)

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