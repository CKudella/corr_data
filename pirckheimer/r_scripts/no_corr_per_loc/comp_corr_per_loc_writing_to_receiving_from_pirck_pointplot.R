require(readr)
require(reshape2)
require(ggplot2)
library(readr)
library(reshape2)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_corr_per_loc/comp_corr_per_loc_writing_to_receiving_from_pirck.csv", fileEncoding="UTF-8", na.strings=c("NULL"), colClasses=c("NoCorrToPirck"="character","NoCorrFromPirck"="character"))

# set number columns to numeric
data$NoCorrToPirck <- as.numeric(as.character(data$NoCorrToPirck))
data$NoCorrFromPirck <- as.numeric(as.character(data$NoCorrFromPirck))

# sum up number of correspondents
data$sumcorr <- data$NoCorrToPirck + data$NoCorrFromPirck

# apply melt for wide to long
data_long <- melt(data, id.vars= c("locations_id","Location.Name.Modern","Latitude","Longitude","sumcorr"))

# create pointplot
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
ggsave("comp_corr_per_loc_writing_to_receiving_from_pirck_pointplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_pirck_pointplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_pirck_pointplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_pirck_pointplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
