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
