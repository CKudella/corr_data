require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_corr_per_loc/comp_corr_per_loc_writing_to_receiving_from_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x=NoCorrToEra, y=NoCorrFromEra, label=Location.Name.Modern)) + 
  geom_point(stat = "identity") +
  geom_smooth(method = lm) +
  scale_x_continuous(trans='log2') +
  scale_y_continuous(trans='log2')
labs(x="NoCorrToEra",y="NoCorrFromEra") + 
  theme_bw()
plot
