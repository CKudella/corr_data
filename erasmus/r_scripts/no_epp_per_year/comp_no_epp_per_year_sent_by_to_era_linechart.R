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
data<-read.csv("no_epp_per_year/comp_no_epp_per_year_sent_by_to_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# apply melt for wide to long
data_long <- melt(data, id.vars= c("send_date_year1"))

# create linechart
plot <- ggplot(data=data_long, aes(x= send_date_year1, y=value, colour=variable)) +
  geom_line(stat = "identity", size=0.9) +
  geom_point(shape=1) + labs(x="Year",y="Number of letters") +
  scale_x_continuous(breaks = c(1484:1536)) +
  scale_y_continuous(breaks = seq(0,160,10)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(legend.position="bottom") +
  scale_color_grey(labels = c("Letters sent from Erasmus", "Letters sent to Erasmus"))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("comp_no_epp_per_year_sent_by_to_era_linechart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_sent_by_to_era_linechart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_sent_by_to_era_linechart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("comp_no_epp_per_year_sent_by_to_era_linechart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
