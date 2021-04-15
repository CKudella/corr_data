require(readr)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_corr_per_loc/no_corr_per_loc_receiving_from_budé_with_geocoordinates.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create pointplot
plot <- ggplot(data = data, aes(x = reorder(Location.Name.Modern, -Number.of.correspondents.who.received.at.this.location.letters.from.Budé), y = Number.of.correspondents.who.received.at.this.location.letters.from.Budé, label = Location.Name.Modern)) +
  geom_point(stat = "identity") +
  labs(x = "Locations", y = "Number of correspondents receiving letters from Budé") +
  scale_y_continuous(breaks = seq(0, 14, 1)) +
  theme_bw() +
  theme(axis.title.x = element_text(), axis.text.x = element_blank(), axis.ticks.x = element_blank())
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_corr_per_loc_receiving_from_budé_pointplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_budé_pointplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_budé_pointplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_receiving_from_budé_pointplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
