require(readr)
require(timelineS)
library(readr)
library(timelineS)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
data<-read.csv("duration_of_correspondence/duration_reciproc_pirck.csv", fileEncoding="UTF-8", colClasses=c("Start.of.Correspondence"="Date","End.of.Correspondence"="Date"))

# calculate duration of correspondence
data$duration <- durCalc(data, start="Start.of.Correspondence", end="End.of.Correspondence", timeunit="years")

#durPlot (scatterplot) for duration of correspondence in correlation to the beginning of the correspondence
durPlot(df=data, start="Start.of.Correspondence", end="End.of.Correspondence", plot_type="scatter", timeunit = "years", point_size = 1)

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_reciproc_pirck_scatterplot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_reciproc_pirck_scatterplot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_reciproc_pirck_scatterplot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_reciproc_pirck_scatterplot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
