require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
data<-read.csv("no_epp_per_loc/avg_no_epp_per_loc_year_written_by_era_to.csv", fileEncoding="UTF-8")

# create potblox
plot <- ggplot(data, aes(x= ' ', y = Average.Number.of.Letters.written.by.Erasmus.to.this.location.per.year)) +
  geom_boxplot(outlier.size=2, notch = FALSE) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(y = "Average Number of letters sent by Erasmus to location per year")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_loc_year_written_by_era_to_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_by_era_to_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_by_era_to_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_loc_year_written_by_era_to_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)