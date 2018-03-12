require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_loc/comp_epp_per_loc_written_by_era_at_and_sent_by_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x=NoLettersWrittenByErasmusTO, y=NoLettersWrittenByErasmusAT, label=LocationName)) + 
  geom_point(stat = "identity") +
  geom_smooth(method = lm) +
  scale_x_continuous(trans='log2') +
  scale_y_continuous(trans='log2')
labs(x="NoLettersWrittenByErasmusTO",y="NoLettersWrittenBYErasmusAT") + 
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