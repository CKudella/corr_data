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
data<-read.csv("no_epp_per_modern_state/comp_no_epp_from_era_to_ms_and_from_ms_to_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x=Number.of.letters.sent.from.this.modern.state.to.Erasmus, y=Number.of.letters.Erasmus.sent.to.this.modern.state, label=ModernState)) + 
  geom_point(stat = "identity") +
  geom_smooth(method = lm) +
  labs(x="Number.of.letters.sent.from.this.modern.state.to.Erasmus",y="Number.of.letters.Erasmus.sent.to.this.modern.state") + 
  theme_bw()
plot