require(tidyverse)
require(ggrepel)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_loc/comp_epp_per_loc_written_by_era_at_and_sent_by_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x=NoLettersWrittenByErasmusTO, y=NoLettersWrittenBYErasmusAT, label=LocationName)) +
  geom_point(stat = "identity", alpha = 0.25) +
  geom_text_repel(data = filter(data, NoLettersWrittenByErasmusTO > quantile(data$NoLettersWrittenByErasmusTO, 0.75, na.rm = TRUE) + 1.5 * IQR(data$NoLettersWrittenByErasmusTO, na.rm = TRUE) |
                                  NoLettersWrittenBYErasmusAT > quantile(data$NoLettersWrittenBYErasmusAT, 0.75, na.rm = TRUE) + 1.5 * IQR(data$NoLettersWrittenBYErasmusAT, na.rm = TRUE)), 
                  aes(label = LocationName), box.padding = 1.5, max.overlaps = Inf) +
  labs(x="Number of letters sent by Erasmus to this location",y="Number of letters written by Erasmus at this location") +
  theme_bw()
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_per_loc_written_by_era_at_and_sent_by_era_to_log_scatterplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_loc_written_by_era_at_and_sent_by_era_to_log_scatterplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_loc_written_by_era_at_and_sent_by_era_to_log_scatterplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_loc_written_by_era_at_and_sent_by_era_to_log_scatterplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
