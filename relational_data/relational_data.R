library(tidyverse)
library(nycflights13)

flights2 <- flights %>%
    select(year:day, hour, origin, dest, tailnum, carrier)

flights2 %>%
    select(-origin, -dest) %>%
    left_join(airlines, by = "carrier")

top_dest <- flights %>%
    count(dest, sort = TRUE) %>%
    head(10)

flights3 <- flights %>%
    semi_join(top_dest) %>%
    select(dest, dep_delay, everything())

