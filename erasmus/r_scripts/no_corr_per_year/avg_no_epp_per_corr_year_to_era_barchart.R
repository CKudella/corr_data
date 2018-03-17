require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
data<-read.csv("no_corr_per_year/avg_no_epp_per_corr_year_to_era.csv", fileEncoding="UTF-8")

# create barchart
plot <- ggplot(data,aes(x= Year, y=Average.number.of.letters.sent.per.correspondent.to.Erasmus.this.year)) + 
  geom_bar(position = "dodge", stat = "identity") + 
  labs(x="Year",y="Average number of letters") +
  scale_x_continuous(breaks = c(1484:1536)) +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + 
  theme(legend.position="bottom")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_corr_year_to_era_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_era_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_era_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_year_to_era_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)