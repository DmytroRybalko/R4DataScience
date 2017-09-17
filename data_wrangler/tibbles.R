library(tidyverse)
library(nycflights13)

vignette("tibble")
package?tibble

# Control the default appearance with options:
# options(tibble.print_max = n, tibble.print_min = m)

# Will always print all columns, regardless of the width of the screen.
# options(tibble.width = Inf)

# Explicitly print() the data frame and control the number of rows
flights %>%
    print(n = 10, width = Inf)

tibble(
    x = 1:5, 
    y = 1, 
    z = x ^ 2 + y
)

## Subsetting
df <- tibble(
    x = runif(5),
    y = rnorm(5)
)

df$x
df[["x"]]
df[[1]]

# To use these in a pipe
df %>% .$x
