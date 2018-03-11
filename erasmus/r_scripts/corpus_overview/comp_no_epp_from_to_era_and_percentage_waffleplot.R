require(ggplot2)
require(waffle)
library(ggplot2)
library(waffle)

# set working directory
getwd()
setwd("../query_results/")

parts <- c('Ammount of letters sent to Erasmus'=1140, 'Ammount of letters sent by Erasmus'=1958)

waffle(parts/5, rows=10, size=0.1, colors=c("#bdbdbd", "#636363"),legend_pos="bottom")