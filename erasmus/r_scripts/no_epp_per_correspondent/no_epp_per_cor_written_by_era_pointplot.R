require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_correspondent/no_epp_per_cor_written_by_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x= reorder(recipient_id, -Number.of.letters.sent.from.Erasmus.to.this.correspondent), y=Number.of.letters.sent.from.Erasmus.to.this.correspondent, label=recipient_id)) + 
  geom_point(stat = "identity") + 
  labs(x="Correspondents",y="Number of letters received from from Erasmus") +
  theme_bw() +
  theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plot
