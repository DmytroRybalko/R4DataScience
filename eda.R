################################
######### 7.3.4 Exercises ######
################################
### Explore  y, and z variables in diamonds.
### What do you learn? Think about a diamond and how you might decide which
### dimension is the length, width, and depth.
# 1. The distribution of each of the x
ggplot(data = diamonds, mapping = aes(x = x)) +
    geom_bar(binwidth = 0.05) +
    coord_cartesian(xlim = c(3, 10))

# 2. The distribution of each of the y
ggplot(data = diamonds, mapping = aes(x = y)) +
    geom_bar(binwidth = 0.05) +
    coord_cartesian(xlim = c(3, 10))

# 3. The distribution of each of the z
ggplot(data = diamonds, mapping = aes(x = z)) +
    geom_bar(binwidth = 0.05) +
    coord_cartesian(xlim = c(2, 6))

### 2. Explore the distribution of price. Do you discover anything unusual or
### surprising? (Hint: Carefully think about the binwidth and make sure you try
### a wide range of values.)
ggplot(data = diamonds, mapping = aes(x = price)) + 
    geom_histogram(binwidth = 100)

### 3. How many diamonds are 0.99 carat? How many are 1 carat? What do you think
### is the cause of the difference?

diamonds %>%
    filter(carat == 0.99) %>%
    count()

diamonds %>%
    filter(carat == 1) %>%
    count()


################################
