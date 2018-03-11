require(readr)
require(reshape2)
require(ggplot2)
library(readr)
library(reshape2)
library(ggplot2)

# # read data
data<-read.csv("no_epp_per_modern_state/comp_no_epp_from_era_to_ms_and_from_ms_to_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# apply melt for wide to long
data_long <- melt(data, id.vars= c("ModernState"))

# create barchart
plot <- ggplot(data_long,aes(x= reorder(ModernState,-value),y=value, fill=variable)) + 
  geom_bar(position = "dodge", stat = "identity") + 
  labs(x="Modern State",y="Number of correspondents") + 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) + 
  theme(legend.position="bottom")
plot