library(ggplot2)
library(waffle)

# this is meant as a replacement for figure 16 in the defended thesis version

parts <- c('Ammount of letters sent to Erasmus'=1140, 'Ammount of letters sent by Erasmus'=1958)

waffle(parts/5, rows=10, size=0.1, colors=c("#bdbdbd", "#636363"),legend_pos="bottom")