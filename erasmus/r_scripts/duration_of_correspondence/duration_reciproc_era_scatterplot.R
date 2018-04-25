require(readr)
require(timelineS)
require(ggplot2)
library(readr)
library(timelineS)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
data<-read.csv("duration_of_correspondence/dates_begin_end_reciproc_correspondence.csv", fileEncoding="UTF-8", colClasses=c("Start.of.correspondence"="Date","End.of.correspondence"="Date"))

# calculate duration of correspondence
data$duration <- durCalc(data, start="Start.of.correspondence", end="End.of.correspondence", timeunit="years")

#durPlot (scatterplot) for duration of correspondence in correlation to the beginning of the correspondence
durPlot(df=data, start="Start.of.correspondence", end="End.of.correspondence", plot_type="scatter", timeunit = "years", point_size = 1)

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_reciproc_era_scatterplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_reciproc_era_scatterplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_reciproc_era_scatterplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_reciproc_era_scatterplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
