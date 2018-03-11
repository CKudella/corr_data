require(readr)
require(reshape2)
require(ggplot2)
library(readr)
library(reshape2)
library(ggplot2)

# read data
data<-read.csv("no_epp_per_year/no_epp_per_year_with_non_inferred_send_date_sent_by_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create barchart
plot <- ggplot(data=data, aes(x=Year,y=Number.of.letters.with.non.inferred.send.date.sent.by.Erasmus.this.year)) + 
  geom_bar(stat = "identity") + 
  geom_text(aes(label=Number.of.letters.with.non.inferred.send.date.sent.by.Erasmus.this.year), vjust=-0.5, color='black', size = 2.5) +
  labs(x="Year",y="Number of letters") +
  scale_x_continuous(breaks = c(1484:1536)) +
  scale_y_continuous(breaks = seq(0,240,10)) +
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot
