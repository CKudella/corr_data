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
data<-read.csv("no_epp_per_loc/avg_no_epp_per_corr_loc_written_by_pirck_to.csv", fileEncoding="UTF-8")

# create boxplot
plot <- ggplot(data, aes(x= ' ', y = Average.Number.of.letters.per.correspondent)) +
  geom_boxplot(outlier.size=2, notch = FALSE) +
  geom_text_repel(label=ifelse(data$Average.Number.of.letters.per.correspondent>5,as.character(data$Location.Name),'')) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(y = "Average number of letters sent from Pirckheimer to this location per correspondent")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_corr_loc_written_by_pirck_to_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_loc_written_by_pirck_to_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_loc_written_by_pirck_to_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_loc_written_by_pirck_to_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
