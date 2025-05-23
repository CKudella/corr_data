require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/no_epp_per_loc_written_by_budé_at_outliers.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create facet grid with bar charts
plot <- ggplot(data = data, aes(x = YEAR, y = COUNT)) +
  geom_bar(stat = "identity") +
  labs(x = "Year", y = " Number of letters written by Budé at this location") +
  scale_x_continuous(breaks = c(1503:1540)) +
  facet_grid(locations_name_modern ~ ., space = "free") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(strip.text.y = element_text(angle = 0, hjust = 1)) +
  theme(legend.position = "bottom")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_written_by_budé_at_outliers_barchart_facet_grid.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_budé_at_outliers_barchart_facet_grid.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_budé_at_outliers_barchart_facet_grid.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_budé_at_outliers_barchart_facet_grid.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
