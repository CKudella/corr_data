require(readr)
require(reshape2)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_loc/comp_corr_per_loc_writing_to_receiving_from_budé.csv", fileEncoding = "UTF-8", na.strings = c("NULL"), colClasses = c("NoCorrToBudé" = "character", "NoCorrFromBudé" = "character"))

# set number columns to numeric
data$NoCorrToBudé <- as.numeric(as.character(data$NoCorrToBudé))
data$NoCorrFromBudé <- as.numeric(as.character(data$NoCorrFromBudé))

# sum up number of correspondents
data$sumcorr <- data$NoCorrToBudé + data$NoCorrFromBudé

# apply melt for wide to long
data_long <- melt(data, id.vars = c("locations_id", "Location.Name.Modern", "Latitude", "Longitude", "sumcorr"))

# create pointplot
plot <- ggplot(data_long, aes(x = reorder(Location.Name.Modern, -sumcorr), y = value, colour = variable)) +
  geom_point() +
  labs(x = "Location", y = "Number of correspondents") +
  theme_bw() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_corr_per_loc_writing_to_receiving_from_budé_pointplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_budé_pointplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_budé_pointplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_budé_pointplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
