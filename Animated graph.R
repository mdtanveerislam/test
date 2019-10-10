# Animated plot

install.packages('gganimate')
install.packages(gapminder)
devtools::install_github('thomasp85/gganimate')
install.packages(gifski)

library(ggplot2)
library(gganimate)
theme_set(theme_bw())

library(gifski)
library(gapminder)
head(gapminder)


##  Transition through distinct states in time
setwd("C:/Users/keya_/OneDrive/Desktop/Map in R")


my.animation <- 
  ggplot(
    gapminder,
    aes(x = gdpPercap, y = lifeExp, colour = continent, size = pop,frame=year)
  ) +
  geom_point(alpha = 0.6) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life expectancy")

my.animation + transition_time(year)+ labs(title = "Year: {frame_time}") 

anim_save("Gapminder_example.gif")
#@@@@@@
my.animation + facet_wrap(~continent) +
  transition_time(year) +
  labs(title = "Year: {frame_time}")

anim_save("Gapminder_example1.gif")
######
head(airquality)

p <- ggplot(
  airquality,
  aes(Day, Temp, group = Month, color = factor(Month))
) +
  geom_line() +
  scale_color_viridis_d() +
  labs(x = "Day of Month", y = "Temperature",col="Month") +
  theme(legend.position = "top")
p

p +  geom_point() + transition_reveal(Day)

anim_save("Gapminder_temp.gif")

# 
p + geom_point(aes(group = seq_along(Day))) +transition_reveal(Day)

anim_save("Gapminder_temp1.gif")


# Transition between several distinct stages of the data

library(dplyr)
mean.temp <- airquality %>%
  group_by(Month) %>%
  summarise(Temp = mean(Temp))
mean.temp

# Create a bar plot of mean temperature:


p1 <- ggplot(mean.temp, aes(Month, Temp, fill = Temp)) +
  geom_col() +
  scale_fill_distiller(palette = "Reds", direction = 1) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    panel.grid.major.y = element_line(color = "white"),
    panel.ontop = TRUE
  )
p1+ ggtitle("Monthly mean temparature")

p1 + transition_states(Month, wrap = FALSE) +
  shadow_mark()

anim_save("bargraph_temp.gif")
