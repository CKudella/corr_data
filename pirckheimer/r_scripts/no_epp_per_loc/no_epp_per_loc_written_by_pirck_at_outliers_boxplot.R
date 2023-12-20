require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/no_epp_per_loc_written_by_pirck_at_outliers.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# identify outliers and their years for each location
outliers_df <- data %>%
  group_by(locations_name_modern) %>%
  mutate(
    Q1 = quantile(COUNT, 0.25),
    Q3 = quantile(COUNT, 0.75),
    IQR = Q3 - Q1,
    lower_bound = Q1 - 1.5 * IQR,
    upper_bound = Q3 + 1.5 * IQR,
    is_outlier = COUNT < lower_bound | COUNT > upper_bound,
    outlier_years = ifelse(is_outlier, as.character(YEAR), "")
  ) %>%
  filter(is_outlier) %>%
  ungroup()

# create box plot
plot <- ggplot(data, aes(x = locations_name_modern, y = COUNT)) +
  geom_boxplot(notch = FALSE) +
  geom_text(data = outliers_df, aes(x = locations_name_modern, y = COUNT, label = outlier_years), size = 3, vjust = -1) +
  labs(x = "Outlier Location", y = "Number of letters written by Pirckheimer at this location") +
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
