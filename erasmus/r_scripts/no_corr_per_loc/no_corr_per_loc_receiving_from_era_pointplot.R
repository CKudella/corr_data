require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_loc/no_corr_per_loc_receiving_from_era_with_geocoordinates.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create pointplot
plot <- ggplot(data = data, aes(x = reorder(Location.Name.Modern, -Number.of.correspondents.who.received.at.this.location.letters.from.Erasmus), y = Number.of.correspondents.who.received.at.this.location.letters.from.Erasmus, label = Location.Name.Modern)) +
  geom_point(stat = "identity") +
  geom_hline(aes(yintercept = mean(Number.of.correspondents.who.received.at.this.location.letters.from.Erasmus), linetype = "mean"), size = 0.3) +
  geom_hline(aes(yintercept = median(Number.of.correspondents.who.received.at.this.location.letters.from.Erasmus), linetype = "median"), size = 0.3) +
  labs(x = "Location", y = "Number of correspondents at this location to whom Erasmus wrote") +
  theme_bw() +
  theme(legend.position = "bottom") +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_corr_per_loc_receiving_from_era_pointplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_era_pointplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_era_pointplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_era_pointplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
