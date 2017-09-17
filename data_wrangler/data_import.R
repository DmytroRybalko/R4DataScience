library(tidyverse)
# Read inline csv file
read_csv("a,b,c
1,2,3
4,5,6")

read_csv("1,2,3\n4,5,6", col_names = FALSE)

read_csv("The first line of metadata
  The second line of metadata
  x,y,z
  1,2,3", skip = 2)

#########################################
######### Parsing a vectors #############
#########################################
parse_double("1.23")
parse_double("1,23", locale = locale(decimal_mark = ","))

parse_number("$100")
parse_number("20%")
parse_number("It cost $125.43")
parse_number("$123,456,789")
parse_number("123.456.789", locale = locale(grouping_mark = "."))
parse_number("123'456'789", locale = locale(grouping_mark = "'"))

d1 <- "January 1, 2010"
parse_date(d1, "%B %d, %Y")
