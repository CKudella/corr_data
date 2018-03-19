require(readr)
require(reshape2)
require(ggplot2)
require(scales)
library(readr)
library(reshape2)
library(ggplot2)
library(scales)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_year/comp_no_epp_per_year_inferred_noninferred_sent_from_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# apply melt for wide to long
data_long <- melt(data, id.vars= c("Year"))

# create stacked barchart
plot <- ggplot(data_long,aes(x=Year,y=value, fill=variable)) +
  geom_bar(position = "fill", stat = "identity") +
  scale_y_continuous(labels = percent_format()) +
  labs(x="Year",y="Number of letters") + scale_x_continuous(breaks = c(1484:1536)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position="bottom") +
  scale_fill_grey(labels = c("Letters sent from Erasmus with inferred send date", "Letters sent from Erasmus with non-inferred send date"))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_per_year_inferred_noninferred_sent_from_era_barchart_percentage.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_inferred_noninferred_sent_from_era_barchart_percentage.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_inferred_noninferred_sent_from_era_barchart_percentage.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_inferred_noninferred_sent_from_era_barchart_percentage.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
