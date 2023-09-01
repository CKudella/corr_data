require(tidyverse)
require(ggrepel)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_loc/comp_epp_per_loc_sent_to_era_from_and_by_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x=NoLettersWrittenTOErasmus, y=NoLettersWrittenBYErasmusTO, label=LocationName)) +
  geom_point(stat = "identity", alpha = 0.25) +
  geom_text_repel(data = filter(data, NoLettersWrittenTOErasmus > quantile(data$NoLettersWrittenTOErasmus, 0.75, na.rm = TRUE) + 1.5 * IQR(data$NoLettersWrittenTOErasmus, na.rm = TRUE) |
                                  NoLettersWrittenBYErasmusTO > quantile(data$NoLettersWrittenBYErasmusTO, 0.75, na.rm = TRUE) + 1.5 * IQR(data$NoLettersWrittenBYErasmusTO, na.rm = TRUE)), 
                  aes(label = LocationName), box.padding = 1.5, max.overlaps = Inf) + 
  labs(x = "Number of letters sent to Erasmus from this location", y = "Number of letters sent by Erasmus to this location") +
  theme_bw()
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_epp_per_loc_sent_to_era_from_and_by_era_scatterplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_era_from_and_by_era_scatterplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_era_from_and_by_era_scatterplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_epp_per_loc_sent_to_era_from_and_by_era_scatterplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
