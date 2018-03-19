require(readr)
require(timelineS)
library(readr)
library(timelineS)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
data<-read.csv("duration_of_correspondence/duration_of_correspodence_all_corr.csv", fileEncoding="UTF-8", colClasses=c("Beginning.of.correspondence.with.Budé"="Date","End.of.the.correspondence.with.Budé"="Date"))

# calculate duration of correspondence
data$duration <- durCalc(data, start="Beginning.of.correspondence.with.Budé", end="End.of.the.correspondence.with.Budé", timeunit="years")

#durPlot (density) for duration of correspondence in correlation to the beginning of the correspondence
durPlot(df=data, start="Beginning.of.correspondence.with.Budé", end="End.of.the.correspondence.with.Budé", plot_type="density", timeunit = "years")

# change working directory
getwd()
setwd("../r_plots/")

# save plot in multiple formats
ggsave("duration_of_correspodence_all_corr_density_plot.pdf", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspodence_all_corr_density_plot.png", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspodence_all_corr_density_plot.eps", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
ggsave("duration_of_correspodence_all_corr_density_plot.svg", plot = last_plot(), scale = 1, width = 11.7, height = 8.3, units = "in", dpi = 600, limitsize = TRUE)
