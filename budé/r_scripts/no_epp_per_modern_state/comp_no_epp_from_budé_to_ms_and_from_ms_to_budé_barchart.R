require(readr)
require(reshape2)
require(ggplot2)
library(readr)
library(reshape2)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_modern_state/comp_no_epp_from_era_to_ms_and_from_ms_to_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# apply melt for wide to long
data_long <- melt(data, id.vars= c("ModernState"))

# create barchart
plot <- ggplot(data_long,aes(x= reorder(ModernState,-value),y=value, fill=variable)) + 
  geom_bar(position = "dodge", stat = "identity") + 
  labs(x="Modern State",y="Number of correspondents") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + 
  theme(legend.position="bottom")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_from_era_to_ms_and_from_ms_to_era_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)