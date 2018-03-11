require(readr)
require(timelineS)
library(readr)
library(timelineS)

# set working directory
getwd()
setwd("../query_results/")

# read data and define data type for date columns
data<-read.csv("duration_of_correspondence/duration_of_correspodence_all_corr.csv", fileEncoding="UTF-8", colClasses=c("Beginning.of.correspondence.with.Erasmus"="Date","End.of.the.correspondence.with.Erasmus"="Date"))

# calculate duration of correspondence
data$duration <- durCalc(data, start="Beginning.of.correspondence.with.Erasmus", end="End.of.the.correspondence.with.Erasmus", timeunit="years")

#durPlot (scatter) for duration of correspondence in correlation to the beginning of the correspondence
durPlot(df=data, start="Beginning.of.correspondence.with.Erasmus", end="End.of.the.correspondence.with.Erasmus", plot_type="scatter", timeunit = "years")