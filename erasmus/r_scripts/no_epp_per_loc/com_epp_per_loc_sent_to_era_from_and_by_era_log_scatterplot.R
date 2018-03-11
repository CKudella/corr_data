require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# read data
data<-read.csv("no_epp_per_loc/comp_epp_per_loc_sent_to_era_from_and_by_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x=NoLettersWrittenTOErasmus, y=NoLettersWrittenBYErasmusTO, label=LocationName)) + 
  geom_point(stat = "identity") +
  geom_smooth(method = lm) +
  scale_x_continuous(trans='log2') +
  scale_y_continuous(trans='log2')
  labs(x="NoLettersWrittenTOErasmus",y="NoLettersWrittenBYErasmusTO") + 
  theme_bw()
plot
