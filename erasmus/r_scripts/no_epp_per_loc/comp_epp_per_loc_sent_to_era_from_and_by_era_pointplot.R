require(readr)
require(dplyr)
require(ggplot2)
library(readr)
library(dplyr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_loc/comp_epp_per_loc_sent_to_era_from_and_by_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# apply melt for wide to long
data_long <- melt(data, id.vars= c("LocationName","Latitude","Longitude"))

# create scatterplot
plot <- ggplot(data_long, aes(x = reorder(LocationName, -value), y = value, colour = variable)) +
  geom_point() +
  labs(x="Locations",y="Number of letters") +
  theme_bw() +
  theme(legend.position="bottom") +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
plot