## Start here!!! 
library(tidyverse)

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy))
## map the colors of your points to the class variable to reveal the class
## of each car
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, color = class))

## In the above example, we mapped class to the color aesthetic, but we could
## have mapped class to the size aesthetic in the same way
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, size = class))

# the transparency of the points
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

# the shape of the point
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy, shape = class))

# Use facets
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) + 
    facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) + 
    facet_grid(drv ~ cyl)

ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) + 
    facet_wrap(~ class, nrow = 2)

?facet_wrap

ggplot(data = mpg) + 
    geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) + 
    geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

# display multiple geoms in the same plot
ggplot(data = mpg) + 
    geom_point(mapping = aes(x = displ, y = hwy)) +
    geom_smooth(mapping = aes(x = displ, y = hwy))

# more simple
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point() + 
    geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
    geom_point(mapping = aes(color = class)) + 
    geom_smooth()
