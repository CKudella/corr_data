require(readr)
require(ggplot2)
library(readr)
library(ggplot2)

# read data
data<-read.csv("no_epp_per_correspondent/no_epp_per_cor_written_to_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create scatterplot
plot <- ggplot(data=data, aes(x= reorder(sender_id, -Number.of.letters.sent.to.Erasmus.from.this.correspondent), y=Number.of.letters.sent.to.Erasmus.from.this.correspondent, label=sender_id)) + 
  geom_point(stat = "identity") + 
  labs(x="Correspondents",y="Number of letters written Erasmus") +
  theme_bw() +
  theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plot