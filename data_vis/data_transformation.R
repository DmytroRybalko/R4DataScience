## Start here!!! 
library(nycflights13)
library(tidyverse)
flights

## Useful tip: save result and print it
(dec25 <- filter(flights, month == 12, day == 25))

## Select every row where x is one of the values in y
(nov_dec <- filter(flights, month %in% c(11, 12)))

## 5.2.4 Exercises:
## Find all flights that
## 1.Had an arrival delay of two or more hours
(my_ans <- filter(flights, arr_delay >= 2))

## 2.Flew to Houston (IAH or HOU)
(my_ans <- filter(flights, dest == "IAH" | dest == "HOU"))
View(my_ans)

## 4.Departed in summer (July, August, and September)
(my_ans <- filter(flights, month %in% c(6, 7, 8)))

## 5.Arrived more than two hours late, but didn’t leave late
(my_ans <- filter(flights, dep_delay == 0 | arr_delay >= 120))

## Use arrange()
(my_ans <- arrange(flights, desc(dep_delay)))

## Use select

## Select columns by name
select(flights, year, month, day)
# Select all columns between year and day (inclusive)
select(flights, year:day)
# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))

(select(flights, time_hour, air_time, everything()))

## Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time,
## and arr_delay from flights.
vars <- c("dep_time", "dep_delay", "arr_time", "arr_delay")
(select(flights, vars))
# Use everything()
(select(flights, dep_time, dep_delay, arr_time, arr_delay, everything()))
# Use one_of()
(select(flights, one_of(vars)))

## Use mutate
flights_sml <- select(flights, 
                      year:day, 
                      ends_with("delay"), 
                      distance, 
                      air_time
)
View(flights_sml)

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours
)

transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
)

## Grouped summaries with summarise()
## grouping doesn't change how the data looks. It changes how it acts with the
## other dplyr verbs
by_day <- group_by(flights, year, month, day)
summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

## For example, let’s look at the planes (identified by their tail number)
## that have the highest average delays:
not_cancelled <- flights %>% 
    filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
    group_by(year, month, day) %>% 
    summarise(mean = mean(dep_delay))

delays <- not_cancelled %>% 
    group_by(tailnum) %>% 
    summarise(
        delay = mean(arr_delay, na.rm = TRUE),
        n = n()
    )

ggplot(data = delays, mapping = aes(x = n, y = delay)) + 
    geom_point(alpha = 1/10)

delays %>% 
    filter(n > 25) %>% 
    ggplot(mapping = aes(x = n, y = delay)) + 
    geom_point(alpha = 1/10)

# Which destinations have the most carriers?
not_cancelled %>% 
    group_by(dest) %>% 
    summarise(carriers = n_distinct(carrier)) %>% 
    arrange(desc(carriers))

## 1. Brainstorm at least 5 different ways to assess the typical delay
## characteristics of a group of flights. Consider the following scenarios:

## 1.1 A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of
## the time
not_cancelled %>% 
    group_by(year, month, day) %>%
    summarise(arr_med = median(arr_delay)) %>%
    filter(arr_med > 15)

## Look at the number of cancelled flights per day. Is there a pattern?
## Is the proportion of cancelled flights related to the average delay?
not_cancelled %>% 
    group_by(year, month, day)
    