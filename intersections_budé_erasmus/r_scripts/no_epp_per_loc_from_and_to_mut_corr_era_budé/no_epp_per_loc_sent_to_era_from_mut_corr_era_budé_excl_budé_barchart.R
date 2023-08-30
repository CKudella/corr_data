require(tidyverse)
require(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_loc_from_and_to_mut_corr_era_budé/no_epp_per_loc_sent_to_era_from_mut_corr_era_budé_excl_budé.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create bar chart
plot <- ggplot(data, aes(x= reorder(Location.Name.Modern, -Number.of.letters.sent.from.this.location.to.Erasmus.from.mutual.correspondents.of.his.and.Budé..excl..Budé.),y=Number.of.letters.sent.from.this.location.to.Erasmus.from.mutual.correspondents.of.his.and.Budé..excl..Budé.)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=Number.of.letters.sent.from.this.location.to.Erasmus.from.mutual.correspondents.of.his.and.Budé..excl..Budé.), vjust=-0.5, color='black') +
  labs(x="Locations",y="Number of letters sent to Erasmus from this location (excluding letters by Budé)") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_sent_to_era_from_mut_corr_era_budé_excl_budé_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_to_era_from_mut_corr_era_budé_excl_budé_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_to_era_from_mut_corr_era_budé_excl_budé_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_to_era_from_mut_corr_era_budé_excl_budé_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
