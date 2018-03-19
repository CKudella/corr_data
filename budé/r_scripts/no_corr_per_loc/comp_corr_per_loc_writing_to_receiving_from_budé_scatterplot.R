require(readr)
require(ggplot2)
require(ggrepel)
library(readr)
library(ggplot2)
library(ggrepel)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_corr_per_loc/comp_corr_per_loc_writing_to_receiving_from_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x=NoCorrFromEra, y=NoCorrToEra, label=Location.Name.Modern)) + 
  geom_point(stat = "identity") +
  geom_text_repel(label=ifelse(data$NoCorrToEra>6,as.character(data$Location.Name.Modern),''), colour = NoCorrToEra) +
  geom_text_repel(label=ifelse(data$NoCorrFromEra>6,as.character(data$Location.Name.Modern),''), colour = NoCorrToEra) +
  labs(x="Number of correspondents receiving letters from Erasmus",y="Number of Correspondents writing letters to Erasmus") + 
  theme_bw()
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_corr_per_loc_writing_to_receiving_from_era_scatterplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_era_scatterplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_era_scatterplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_corr_per_loc_writing_to_receiving_from_era_scatterplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)