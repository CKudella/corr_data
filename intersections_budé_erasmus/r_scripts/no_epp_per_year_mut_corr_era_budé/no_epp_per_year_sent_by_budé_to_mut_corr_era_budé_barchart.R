require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_year_mut_corr_era_budé/no_epp_per_year_sent_by_budé_to_mut_corr_era_budé.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create bar chart
plot <- ggplot(data=data, aes(x=send_date_year1,y= Total.number.of.letters.sent.by.Budé.this.year.to.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.)) +
  geom_bar(stat = "identity") +
  labs(x="Year",y="Number of letters sent by Budé to mutual correspondents") +
  geom_text(aes(label=Total.number.of.letters.sent.by.Budé.this.year.to.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.), vjust=-0.5, color='black') +
  scale_x_continuous(breaks = c(1484:1540)) +
  scale_y_continuous(breaks = seq(0,20,1)) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35)) +
  theme(strip.text.y = element_text(angle = 0, hjust = 1)) +
  theme(legend.position="bottom")
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_year_sent_by_budé_to_mut_corr_era_budé_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_year_sent_by_budé_to_mut_corr_era_budé_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_year_sent_by_budé_to_mut_corr_era_budé_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_year_sent_by_budé_to_mut_corr_era_budé_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
