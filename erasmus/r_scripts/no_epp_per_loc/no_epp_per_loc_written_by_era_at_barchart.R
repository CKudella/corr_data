require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/no_epp_per_loc_written_by_era_at.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create bar chart
plot <- ggplot(data = data, aes(x = reorder(Location.Name, -Number.of.letters.sent.from.this.location.from.Erasmus), y = Number.of.letters.sent.from.this.location.from.Erasmus, label = Location.Name)) +
  geom_bar(stat = "identity") +
  labs(x = "Locations", y = "Number of letters sent from this location by Erasmus") +
  geom_text(aes(label = Number.of.letters.sent.from.this.location.from.Erasmus), vjust = -0.5, color = "black") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_written_by_era_at_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_era_at_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_era_at_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_era_at_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
