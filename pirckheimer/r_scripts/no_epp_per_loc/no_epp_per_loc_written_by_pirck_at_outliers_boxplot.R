require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/no_epp_per_loc_written_by_pirck_at_outliers.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# calculate median for label
data_meds <- summarise(group_by(data, locations_name_modern), med = median(COUNT))

# create box plot
plot <- ggplot(data, aes(x = locations_name_modern, y = COUNT)) +
  geom_boxplot(notch = FALSE) +
  geom_text(data = data_meds, aes(x = locations_name_modern, y = med, label = med), size = 3, vjust = -0.5) +
  labs(x = "Outlier Location", y = " Number of letters sent from this location by Pirckheimer per year") +
  theme_bw()
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_written_by_pirck_at_outliers_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_pirck_at_outliers_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_pirck_at_outliers_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_pirck_at_outliers_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
