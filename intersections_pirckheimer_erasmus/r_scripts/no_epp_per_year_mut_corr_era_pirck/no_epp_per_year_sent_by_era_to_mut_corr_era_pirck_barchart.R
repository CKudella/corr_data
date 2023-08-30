require(tidyverse)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_year_mut_corr_era_pirck/no_epp_per_year_sent_by_era_to_mut_corr_era_pirck.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create bar chart
plot <- ggplot(data=data, aes(x=send_date_year1,y= Total.number.of.letters.sent.by.Erasmus.this.year.to.mutual.correspondents.of.his.and.Pirckheimer..excl..Pirckheimer.)) +
  geom_bar(stat = "identity") +
  labs(x="Year",y="Number of letters sent by Erasmus to mutual correspondents") +
  geom_text(aes(label=Total.number.of.letters.sent.by.Erasmus.this.year.to.mutual.correspondents.of.his.and.Pirckheimer..excl..Pirckheimer.), vjust=-0.5, color='black') +
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
ggsave("no_epp_per_year_sent_by_era_to_mut_corr_era_pirck_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_year_sent_by_era_to_mut_corr_era_pirck_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_year_sent_by_era_to_mut_corr_era_pirck_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_year_sent_by_era_to_mut_corr_era_pirck_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
