require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_modern_state/no_epp_per_modern_state_sent_from_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create barchart
plot <- ggplot(data, aes(x= reorder(Modern.State, -Number.of.letters.Erasmus.sent.to.this.modern.state),y=Number.of.letters.Erasmus.sent.to.this.modern.state)) + 
  geom_bar(stat = "identity") +
  geom_text(aes(label=Number.of.letters.Erasmus.sent.to.this.modern.state), vjust=-0.5, color='black') +
  labs(x="Modern State",y="Number of letters sent to this modern state from Erasmus") +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot