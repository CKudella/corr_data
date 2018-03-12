require(readr)
require(dplyr)
require(reshape2)
require(ggplot2)
library(readr)
library(dplyr)
library(reshape2)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_corr_per_loc/comp_corr_per_loc_writing_to_receiving_from_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"), colClasses=c("NoCorrToEra"="character","NoCorrFromEra"="character"))

# set number columns to numeric
data$NoCorrToEra <- as.numeric(as.character(data$NoCorrToEra))
data$NoCorrFromEra <- as.numeric(as.character(data$NoCorrFromEra))

# sum up number of correspondents
data$sumcorr <- data$NoCorrToEra + data$NoCorrFromEra

# apply melt for wide to long
data_long <- melt(data, id.vars= c("locations_id","Location.Name.Modern","Latitude","Longitude","sumcorr"))

# create scatterplot
plot <- ggplot(data_long, aes(x = reorder(Location.Name.Modern, -sumcorr), y = value, colour = variable)) +
  geom_point() +
  labs(x="Location",y="Number of correspondents") +
  theme_bw() +
  theme(legend.position="bottom") +
  theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_corr_per_loc_writing_to_receiving_from_era_pointplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_era_pointplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_era_pointplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_era_pointplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)