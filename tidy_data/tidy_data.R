library(tidyverse)
table4a

table4a %>%
    gather('1999', '2000', key = "year", value = "case")
table4b
table4b %>%
    gather('1999', '2000', key = "year", value = "population")

tidy4a <- table4a %>%
    gather('1999', '2000', key = "year", value = "case")
tidy4b <- table4b %>%
    gather('1999', '2000', key = "year", value = "population")
left_join(tidy4a, tidy4b)

table2
spread(table2, key = type, value = count)
#########################################
############### Exercises ###############
#########################################
stocks <- tibble(
    year   = c(2015, 2015, 2016, 2016),
    half  = c(1, 2, 1, 2),
    return = c(1.88, 0.59, 0.92, 0.17)
)
stocks
stocks_spread <- stocks %>%
    spread(year, return)
stocks_spread
stocks_gather <- stocks_spread %>%
    gather('2015', '2016', key = "year", value = "return")
stocks_gather
stocks

# What is convert argument?
df <- data.frame(row = rep(c(1, 51), each = 3),
                 var = c("Sepal.Length", "Species", "Species_num"),
                 value = c(5.1, "setosa", 1, 7.0, "versicolor", 2))
df %>% spread(var, value) %>% str
df %>% spread(var, value, convert = TRUE) %>% str

people <- tribble(
    ~name,             ~key,       ~value,
    #-----------------|-----------|-------
    "Phillip Woods",   "age",       45,
    "Phillip Woods",   "height",   186,
    "Phillip Words",   "age",       50,
    "Jessica Cordero", "age",       37,
    "Jessica Cordero", "height",   156
)
people
people %>%
    spread(key = "key", value = "value")

table3 
table3 %>%
    separate(rate, into = c("cases", "population"), convert = T)

##############################################
################# Exercises ##################
##############################################
# 1. What do the extra and fill arguments do in separate()? Experiment with the
# various options for the following two toy datasets.
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>%
    separate(x, c("one", "two", "three"))

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>%
    separate(x, c("one", "two", "three"), extra = "drop")

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>%
    separate(x, c("one", "two", "three"))

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>%
    separate(x, c("one", "two", "three"), fill = "left")
