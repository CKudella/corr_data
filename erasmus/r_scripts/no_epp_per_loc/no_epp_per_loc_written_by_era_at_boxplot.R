require(readr)
require(ggplot2)
require(ggrepel)
library(readr)
library(ggplot2)
library(ggrepel)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
data<-read.csv("no_epp_per_loc/no_epp_per_loc_written_by_era_at.csv", fileEncoding="UTF-8")

# create potblox
plot <- ggplot(data, aes(x= ' ', y = Number.of.letters.sent.from.this.location.from.Erasmus)) +
  geom_boxplot(outlier.size=2, notch = FALSE, show.legend = TRUE) +
  geom_text_repel(label=ifelse(data$Number.of.letters.sent.from.this.location.from.Erasmus>67,as.character(data$Location.Name),'')) +
  theme_bw() +
  theme(axis.title.x=element_blank()) +
  labs(y = "Number of letters sent from this location by Erasmus")
plot


# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("no_epp_per_loc_written_by_era_at_boxplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_era_at_boxplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_era_at_boxplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("no_epp_per_loc_written_by_era_at_boxplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)


