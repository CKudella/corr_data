require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_modern_state_mut_corr_era_pirck/no_epp_per_modern_state_sent_by_era_to_mut_corr_era_pirck_incl_pirck.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create bar chart
plot <- ggplot(data, aes(x= reorder(Name.Modern.State, -Number.of.letters.sent.to.this.modern.state.by.Erasmus.to.mutual.correspondents.of.his.and.Pirckheimer..incl..Pirckheimer.),y=Number.of.letters.sent.to.this.modern.state.by.Erasmus.to.mutual.correspondents.of.his.and.Pirckheimer..incl..Pirckheimer.)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=Number.of.letters.sent.to.this.modern.state.by.Erasmus.to.mutual.correspondents.of.his.and.Pirckheimer..incl..Pirckheimer.), vjust=-0.5, color='black') +
  labs(x="Modern State",y="Number of letters sent by Erasmus to mutual correspondents in this this modern state (incl. Pirckheimer)") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_modern_state_sent_by_era_to_mut_corr_era_pirck_incl_pirck_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_modern_state_sent_by_era_to_mut_corr_era_pirck_incl_pirck_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_modern_state_sent_by_era_to_mut_corr_era_pirck_incl_pirck_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_modern_state_sent_by_era_to_mut_corr_era_pirck_incl_pirck_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
