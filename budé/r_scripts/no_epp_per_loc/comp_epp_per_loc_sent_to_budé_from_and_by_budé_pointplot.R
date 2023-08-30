require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/comp_epp_per_loc_sent_to_budé_from_and_by_budé_to.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# pivot data from wide to long format
data_long <- data %>% pivot_longer(cols = c("NoLettersWrittenTOBudé", "NoLettersWrittenBYBudéTO"), names_to = "variable", values_to = "value")

# create poinplot
plot <- ggplot(data_long, aes(x = reorder(LocationName, -value), y = value, colour = variable)) +
  geom_point() +
  labs(x = "Locations", y = "Number of letters") +
  theme_bw() +
  theme(legend.position = "bottom") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
 plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_epp_per_loc_sent_to_budé_from_and_by_budé_pointplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_budé_from_and_by_budé_pointplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_budé_from_and_by_budé_pointplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_budé_from_and_by_budé_pointplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
