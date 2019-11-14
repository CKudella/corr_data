require(readr)
require(ggplot2)
require(ggrepel)
require(ggpubr)
require(svglite)
library(readr)
library(ggplot2)
library(ggrepel)
library(ggpubr)
library(svglite)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("no_epp_per_loc/avg_no_epp_per_corr_loc_written_to_pirck.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data
data2<-read.csv("no_epp_per_loc/avg_no_epp_per_corr_loc_written_to_pirck.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# create pointplot
plot <- ggplot(data=data, aes(x= reorder(Location.Name, -Average.Number.of.Letters), y=Average.Number.of.Letters, label=Location.Name)) +
  geom_point(stat = "identity") +
  labs(x="Locations",y="Average Number of letters sent from this location per correspondent to Pirckheimer") +
  theme_bw() +
  theme(axis.title.x=element_text(), axis.text.x=element_blank(), axis.ticks.x=element_blank())
plot

# create boxplot
plot2 <- ggplot(data2, aes(x= ' ', y = Average.Number.of.Letters)) +
  geom_boxplot(outlier.size=2, notch = FALSE) +
  geom_text_repel(label=ifelse(data$Average.Number.of.Letters>3.5,as.character(data$Location.Name),'')) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(y = "Average Number of letters sent from this location per correspondent to Pirckheimer")
plot2

# arrange plots
ggarrange(plot, plot2,
          ncol = 2, nrow = 1)

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("avg_no_epp_per_corr_loc_written_to_pirck_pointplot_and_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_loc_written_to_pirck_pointplot_and_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_loc_written_to_pirck_pointplot_and_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("avg_no_epp_per_corr_loc_written_to_pirck_pointplot_and_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
