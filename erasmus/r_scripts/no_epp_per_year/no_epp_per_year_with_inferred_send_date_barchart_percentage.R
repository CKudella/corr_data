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
data<-read.csv("no_epp_per_year/comp_no_epp_per_year_inferred_noninferred.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

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
  scale_fill_grey(labels = c("Letters with inferred send date", "Letters written non-inferred send date"))
plot