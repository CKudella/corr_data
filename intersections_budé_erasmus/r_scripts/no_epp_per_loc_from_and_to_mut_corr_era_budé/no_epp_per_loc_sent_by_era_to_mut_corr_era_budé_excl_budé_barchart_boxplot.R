require(readr)
require(ggplot2)
require(ggrepel)
require(patchwork)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_loc_from_and_to_mut_corr_era_budé/no_epp_per_loc_sent_by_era_to_mut_corr_era_budé_excl_budé.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create barchart
plot1 <- ggplot(data, aes(x= reorder(Location.Name.Modern, -Number.of.letters.sent.to.this.location.by.Erasmus.to.mutual.correspondents.of.his.and.Budé..excl..Budé.),y=Number.of.letters.sent.to.this.location.by.Erasmus.to.mutual.correspondents.of.his.and.Budé..excl..Budé.)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=Number.of.letters.sent.to.this.location.by.Erasmus.to.mutual.correspondents.of.his.and.Budé..excl..Budé.), vjust=-0.5, color='black') +
  labs(x="Locations",y="Number of letters written by Erasmus to mutual correspondents of his and Budé per location") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot1

# create boxplot
plot2 <- ggplot(data, aes(x= ' ', y = Number.of.letters.sent.to.this.location.by.Erasmus.to.mutual.correspondents.of.his.and.Budé..excl..Budé.)) +
  geom_boxplot(outlier.size=2, notch = FALSE) +
  geom_text_repel(label=ifelse(data$Number.of.letters.sent.to.this.location.by.Erasmus.to.mutual.correspondents.of.his.and.Budé..excl..Budé.>12.25,as.character(data$Location.Name.Modern),'')) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(y = "Number of letters written by Erasmus to mutual correspondents of his and Budé per location")
plot2

# combine plots via patchwork
plot1 + plot2

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_sent_by_era_to_mut_corr_era_budé_excl_budé_barchart_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_era_to_mut_corr_era_budé_excl_budé_barchart_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_era_to_mut_corr_era_budé_excl_budé_barchart_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_by_era_to_mut_corr_era_budé_excl_budé_barchart_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
