require(tidyverse)
require(svglite)
require(ggrepel)
require(patchwork)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_loc_from_and_to_mut_corr_era_pirck/no_epp_per_loc_sent_to_pirck_from_mut_corr_era_pirck_excl_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# calculate quartiles
quartiles <- as.numeric(quantile(data$Number.of.letters.sent.from.this.location.to.Pirckheimer.from.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus., probs = c(0.25, 0.5, 0.75)))

# calculate IQR
IQR <- diff(quartiles[c(1, 3)])

# calculate outlier treshold
upper_dots <- min(max(data$Number.of.letters.sent.from.this.location.to.Pirckheimer.from.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.), quartiles[3] + 1.5 * IQR)

# create bar chart
plot1 <- ggplot(data, aes(x= reorder(Location.Name.Modern, -Number.of.letters.sent.from.this.location.to.Pirckheimer.from.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.),y=Number.of.letters.sent.from.this.location.to.Pirckheimer.from.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label=Number.of.letters.sent.from.this.location.to.Pirckheimer.from.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.), vjust=-0.5, color='black') +
  labs(x="Locations",y="Number of letters sent to Pirckheimer from this location (excluding letters by Erasmus)") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))
plot1

# create box plot
plot2 <- ggplot(data, aes(x= ' ', y = Number.of.letters.sent.from.this.location.to.Pirckheimer.from.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.)) +
  geom_boxplot(outlier.size=2, notch = FALSE) +
  geom_hline(aes(yintercept = mean(Number.of.letters.sent.from.this.location.to.Pirckheimer.from.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.), linetype = "mean"), size = 0.3) +
  geom_hline(aes(yintercept = median(Number.of.letters.sent.from.this.location.to.Pirckheimer.from.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.), linetype = "median"), size = 0.3) +
  geom_text_repel(label=ifelse(data$Number.of.letters.sent.from.this.location.to.Pirckheimer.from.mutual.correspondents.of.his.and.Erasmus..excl..Erasmus.> upper_dots,as.character(data$Location.Name.Modern),'')) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(y = "Number of letters sent to Pirckheimer from this location (excluding letters by Erasmus)")
plot2

# combine plots via patchwork
plot1 + plot2

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_sent_to_pirck_from_mut_corr_era_pirck_excl_era_barchart_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_to_pirck_from_mut_corr_era_pirck_excl_era_barchart_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_to_pirck_from_mut_corr_era_pirck_excl_era_barchart_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_sent_to_pirck_from_mut_corr_era_pirck_excl_era_barchart_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
