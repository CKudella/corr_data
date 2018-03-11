require(readr)
require(timelineS)
library(readr)
library(timelineS)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
data<-read.csv("duration_of_correspondence/dates_begin_end_reciproc_correspondence.csv", fileEncoding="UTF-8", colClasses=c("Start.of.correspondence"="Date","End.of.correspondence"="Date"))

# calculate duration of correspondence
data$duration <- durCalc(data, start="Start.of.correspondence", end="End.of.correspondence", timeunit="years")

#durPlot Plot Duration of Correspondence
durPlot(df=data, start="Start.of.correspondence", end="End.of.correspondence", plot_type="scatter", timeunit = "years")