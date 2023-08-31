require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/comp_epp_per_loc_written_by_pirck_at_and_sent_by_pirck_to.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create scatterplot
plot <- ggplot(data = data, aes(x = NoLettersWrittenByPirckheimerTO, y = NoLettersWrittenBYPirckheimerAT, label = LocationName)) +
  geom_point(stat = "identity") +
  geom_text(vjust = -0.5, hjust = 1) +
  labs(x = "Number of letters sent by Pirckheimer to this location", y = "Number of letters written by Pirckheimer at this location") +
  theme_bw()
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_per_loc_written_by_pirck_at_and_sent_by_pirck_to_log_scatterplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_loc_written_by_pirck_at_and_sent_by_pirck_to_log_scatterplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_loc_written_by_pirck_at_and_sent_by_pirck_to_log_scatterplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_loc_written_by_pirck_at_and_sent_by_pirck_to_log_scatterplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
