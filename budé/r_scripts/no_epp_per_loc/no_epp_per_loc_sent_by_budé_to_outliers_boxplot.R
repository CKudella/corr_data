require(readr)
require(dplyr)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/no_epp_per_loc_sent_by_budé_to_outliers.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# callculate median for label
data_meds <- data %>%
  group_by(locations_name_modern) %>%
  summarise(med = median(COUNT))

# create boxplot with facet grid
plot <- ggplot(data, aes(x = locations_name_modern, y = COUNT)) +
  geom_boxplot(notch = FALSE) +
  geom_text(data = data_meds, aes(x = locations_name_modern, y = med, label = med), size = 3, vjust = -0.5) +
  labs(x = "Outlier Location", y = "Number of letters sent from Budé to this location per year") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_sent_by_budé_to_outliers_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_budé_to_outliers_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_budé_to_outliers_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_budé_to_outliers_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
