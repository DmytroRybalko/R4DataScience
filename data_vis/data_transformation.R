## Start here!!! 
library(nycflights13)
library(tidyverse)

vignette("window-functions")

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

################################
####### 5.6.7 Exercises ########
################################
## 1. Brainstorm at least 5 different ways to assess the typical delay
## characteristics of a group of flights. Consider the following scenarios:

## View the number of fligths per day
not_cancelled %>% 
    group_by(year, month, day) %>%
    summarise(flights = n())

## 1.1 A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of
## the time
### 1. Create new variable for 01-01-2013
one_day <- filter(flights,
                  month == 1,
                  day == 1,
                  !is.na(arr_delay)) %>%
    select(month, day, arr_delay)
### 2. Calculate median for this day
one_day %>%
    mutate(med = median(arr_delay))
### 3. Show all flights with arr_delay is 15 min early of 50% of the time 
one_day %>%
    mutate(med = median(arr_delay),
        diff = med - arr_delay) %>%
    filter(diff > 0 & diff <= 15 )
## 4. Show all flights with arr_delay is 15 min later of 50% of the time
one_day %>%
    mutate(med = median(arr_delay),
           diff = arr_delay - med) %>%
    filter(diff >= 15 )

## 5. Solve for whole data: Show all flights with arr_delay is 15 min early
## of 50% of the time 
not_cancelled %>% 
    group_by(year, month, day) %>%
    summarise(flights = n(), 
              arr_med = median(arr_delay),
              fly_15 = sum(arr_med - arr_delay > 0 & arr_med - arr_delay <= 15))

## 1.2 A flight is always 10 minutes late
not_cancelled %>% 
    group_by(year, month, day) %>%
    filter(arr_delay == 10)


## 4. Look at the number of cancelled flights per day. Is there a pattern?
## Is the proportion of cancelled flights related to the average delay?
cancelled <- flights %>%
    filter(is.na(dep_delay), is.na(arr_delay))
    
cancelled %>%
    group_by(year, month, day) %>%
    summarise(canc = n())
    
flights %>% 
    group_by(year, month, day) %>% 
    summarise(all_fly = n(),
              fly = sum(!is.na(dep_delay)),
              no_fly = sum(is.na(dep_delay)),
              avg_fly = mean(dep_delay, na.rm = T))



################################
####### 5.7.1 Exercises ########
################################

## Which plane (tailnum) has the worst on-time record?
flights %>%
    arrange(desc(arr_delay))

## What time of day should you fly if you want to avoid delays as much as
## possible?
### 1. Choose flights without delay
no_delay <- flights %>%
    filter(dep_delay == 0) %>%
    transmute(sched_dep_time,
              hour = sched_dep_time %/% 100,
              minute = sched_dep_time %% 100)
no_delay
### 2. Grouped flights by hour
no_delay %>%
    group_by(hour) %>%
    summarise(N = n()) %>%
    arrange(desc(N))

## For each destination, compute the total minutes of delay.
### 1. Choose all flights with delays:
not_cancelled <- flights %>% 
    filter(!is.na(dep_delay))
not_cancelled
### 2. Grouped flights by dest and count sum
not_cancelled %>%
    group_by(dest) %>%
    summarise(total = sum(dep_delay)) %>%
    arrange(desc(total))

### 3. For each flight compute the proportion of the total delay for its
### destination.
not_cancelled %>%
    mutate(prop = dep_delay / sum(dep_delay)) %>%
    group_by(dest) %>%
    summarise(total = sum(dep_delay),
              tot_prop = sum(prop)) %>%
    arrange(desc(total))

### 4. Look at each destination. Can you find flights that are suspiciously
### fast? (i.e. flights that represent a potential data entry error).
not_cancelled %>%
    group_by(dest) %>%
    select(dest, air_time, distance) %>%
    arrange(dest, desc(air_time))
### Compute the air time a flight relative to the shortest flight to that
### destination. Which flights were most delayed in the air?
not_cancelled %>%
    group_by(dest) %>%
    select(dest, air_time, distance) %>%
    mutate(rel_time = air_time / min(air_time, na.rm = T)) %>%
    arrange(desc(rel_time))

### 5. Find all destinations that are flown by at least two carriers. Use that
### information to rank the carriers.
flights %>%
    group_by(dest) %>%
    summarise(carriers = n_distinct(carrier)) %>%
    filter(carriers > 1) %>%
    arrange(desc(carriers)) 
    
### 6. For each plane, count the number of flights before the first delay of
### greater than 1 hour.
not_cancelled <- flights %>% 
    filter(!is.na(dep_delay)) %>%
    select(tailnum, time_hour, dep_delay) %>%
    arrange(time_hour)

test <- not_cancelled %>%
    group_by(tailnum) %>%
    mutate(n = 1:n()) %>%
    top_n(1, dep_delay > 60) %>%
    #filter(tailnum == "N108UW")
    summarise(up_60 = first(n) - 1)

### Let`s check our solution for particualar flights:
N0EGMQ_354 <- not_cancelled %>%
    filter(tailnum == "N0EGMQ")
    
res_354 <- N0EGMQ_354 %>%
    mutate(n = 1:n()) %>%
    top_n(1, dep_delay > 60)
res_354_2 <- res_354[1,4] - 1
res_354_2 # right ans: 53
### Let`s check our solution for N104UW:
N104UW_47 <- not_cancelled %>%
    filter(tailnum == "N104UW")

res_47 <- N104UW_47 %>%
    mutate(n = 1:n()) %>%
    top_n(1, dep_delay > 60)
res_47_2 <- res_47[1,4] - 1
res_47_2 # right ans: 3

### Let`s check our solution for particualar flights:
N102UW_46 <- not_cancelled %>%
    filter(tailnum == "N108UW")

### We should stop at line 37 by data 2013-08-13 12:00:00
res <- N102UW_46 %>%
    mutate(n = 1:n()) %>%
    top_n(1, dep_delay > 60)
res2 <- res[1,4] - 1
res2 # right ans: 36