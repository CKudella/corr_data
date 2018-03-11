require(readr)
require(reshape2)
require(ggplot2)
library(readr)
library(reshape2)
library(ggplot2)

# read data
data<-read.csv("no_epp_per_modern_state_year/no_epp_from_era_to_modern_state_per_year.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# plot facet grid
plot <- ggplot(data=data, aes(x=send_date_year1,y=Number.of.letters.Erasmus.sent.to.this.modern.state.this.year)) + 
  geom_bar(stat = "identity") + 
  labs(x="Year",y="Number of letters") + 
  scale_x_continuous(breaks = c(1484:1536)) +
  facet_grid(Modern.State ~ ., space = "free" )+
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(strip.text.y = element_text(angle = 0, hjust = 1)) + 
  theme(legend.position="bottom")
plot