require(readr)
require(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_loc_from_and_to_mut_corr_era_pirck/no_epp_per_loc_sent_by_pirck_to_mut_corr_era_pirck_excl_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create barchart
plot <- ggplot(data, aes(x= reorder(Location.Name.Modern, -Number.of.letters.sent.to.this.location.by.Pirckheimer.to.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.),y=Number.of.letters.sent.to.this.location.by.Pirckheimer.to.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=Number.of.letters.sent.to.this.location.by.Pirckheimer.to.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.), vjust=-0.5, color='black') +
  labs(x="Locations",y="Number of letters sent from Pirckheimer to this location") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_sent_by_pirck_to_mut_corr_era_pirck_excl_era_barchart.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_pirck_to_mut_corr_era_pirck_excl_era_barchart.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_pirck_to_mut_corr_era_pirck_excl_era_barchart.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_pirck_to_mut_corr_era_pirck_excl_era_barchart.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
