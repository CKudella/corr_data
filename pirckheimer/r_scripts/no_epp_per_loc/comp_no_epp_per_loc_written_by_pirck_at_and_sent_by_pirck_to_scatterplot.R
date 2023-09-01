require(tidyverse)
require(ggrepel)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data <- read.csv("no_epp_per_loc/comp_epp_per_loc_written_by_pirck_at_and_sent_by_pirck_to.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x=NoLettersWrittenByPirckheimerTO , y=NoLettersWrittenBYPirckheimerAT, label=LocationName)) +
  geom_point(stat = "identity", alpha = 0.25) +
  geom_text_repel(data = filter(data, NoLettersWrittenByPirckheimerTO > quantile(data$NoLettersWrittenByPirckheimerTO, 0.75, na.rm = TRUE) + 1.5 * IQR(data$NoLettersWrittenByPirckheimerTO, na.rm = TRUE) |
                                  NoLettersWrittenBYPirckheimerAT > quantile(data$NoLettersWrittenBYPirckheimerAT, 0.75, na.rm = TRUE) + 1.5 * IQR(data$NoLettersWrittenBYPirckheimerAT, na.rm = TRUE)), 
                  aes(label = LocationName), box.padding = 1.5, max.overlaps = Inf) +
  labs(x="Number of letters sent by Pirckheimer to this location",y="Number of letters written by Pirckheimer at this location") +
  theme_bw()
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_per_loc_written_by_pirck_at_and_sent_by_pirck_to_scatterplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_loc_written_by_pirck_at_and_sent_by_pirck_to_scatterplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_loc_written_by_pirck_at_and_sent_by_pirck_to_scatterplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_loc_written_by_pirck_at_and_sent_by_pirck_to_scatterplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
