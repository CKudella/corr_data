require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_corr_per_loc/comp_corr_per_loc_writing_to_receiving_from_pirck.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x=NoCorrFromPirck, y=NoCorrToPirck, label=Location.Name.Modern)) + 
  geom_point(stat = "identity") +
  labs(x="Number of correspondents receiving letters from Pirckheimer",y="Number of Correspondents writing letters to Pirckheimer") + 
  theme_bw()
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_corr_per_loc_writing_to_receiving_from_pirck_scatterplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_pirck_scatterplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_pirck_scatterplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_pirck_scatterplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)