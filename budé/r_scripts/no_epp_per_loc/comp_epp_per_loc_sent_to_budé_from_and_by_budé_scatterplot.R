require(tidyverse)
require(ggrepel)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/comp_epp_per_loc_sent_to_budé_from_and_by_budé_to.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create scatter plot
plot <- ggplot(data = data, aes(x = NoLettersWrittenTOBudé, y = NoLettersWrittenBYBudéTO, label = LocationName)) +
  geom_point(stat = "identity") +
  geom_text_repel(vjust = -0.5, hjust = 1) +
  labs(x = "Number of letters written to Budé", y = "Number of letters received from Budé") +
  theme_bw()
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_epp_per_loc_sent_to_budé_from_and_by_budé_scatterplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_budé_from_and_by_budé_scatterplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_budé_from_and_by_budé_scatterplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_budé_from_and_by_budé_scatterplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
