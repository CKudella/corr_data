require(readr)
require(ggplot2)
require(ggrepel)
require(ggpubr)
library(readr)
library(ggplot2)
library(ggrepel)
library(ggpubr)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_corr_per_loc/no_corr_per_loc_writing_to_era_with_geocoordinates.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create pointplot
plot <- ggplot(data=data, aes(x= reorder(Location.Name.Modern, -Number.of.correspondents.who.wrote.from.this.location.letters.to.Erasmus), y=Number.of.correspondents.who.wrote.from.this.location.letters.to.Erasmus, label=Location.Name.Modern)) + 
  geom_point(stat = "identity") + 
  labs(x="Locations",y="Number of correspondents writing letters to Erasmus") +
  theme_bw() +
  theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plot

# create boxplot
plot2 <- ggplot(data, aes(x= ' ', y = Number.of.correspondents.who.wrote.from.this.location.letters.to.Erasmus)) +
  geom_boxplot(outlier.size=2, notch = FALSE) +
  geom_text_repel(label=ifelse(data$Number.of.correspondents.who.wrote.from.this.location.letters.to.Erasmus>6,as.character(data$Location.Name.Modern),'')) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(y = "Number of correspondents writing letters to Erasmus")
plot2

# arrange plots
ggarrange(plot, plot2, 
          ncol = 2, nrow = 1)

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_corr_per_loc_writing_to_era_pointplot_and_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_writing_to_era_pointplot_and_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_writing_to_era_pointplot_and_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_corr_per_loc_writing_to_era_pointplot_and_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)