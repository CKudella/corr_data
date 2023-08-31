require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/comp_epp_per_loc_sent_to_pirck_from_and_by_pirck_to.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create scatterplot
plot <- ggplot(data = data, aes(x = NoLettersWrittenTOPirckheimer, y = NoLettersWrittenBYPirckheimerTO, label = LocationName)) +
  geom_point(stat = "identity") +
  labs(x = "Number of letters written to Pirckheimer", y = "Number of letters received from Pirckheimer") +
  theme_bw()
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_epp_per_loc_sent_to_pirck_from_and_by_pirck_scatterplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_pirck_from_and_by_pirck_scatterplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_pirck_from_and_by_pirck_scatterplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_pirck_from_and_by_pirck_scatterplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
