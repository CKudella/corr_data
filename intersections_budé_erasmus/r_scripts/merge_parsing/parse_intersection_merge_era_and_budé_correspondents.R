require(readr)
require(ggplot2)
library(readr)
library(tidyverse)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data
data<-read.csv("merge_scripts/intersection_merge/intersection_merge_era_and_budé_correspondents.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# cut uncessary label parts from Label column
data$Label <- gsub("\\b(\\W+COE+.*)", "", data$Label)
data$Label <- gsub("^(\\W+E)", "E", data$Label)

# add colour column for mutual correspondents to be used with the "give colour to nodes" plugin for gephi
data$colour <- "#fdb863"

#assign specific colour for erasmus
data$colour <- ifelse(data$Id == "erasmus_desiderius_viaf_95982394", as.character("#e66101"), data$colour)

#assign specific colour for budé
data$colour <- ifelse(data$Id == "budé_guillaume_viaf_105878228", as.character("#5e3c99"), data$colour)

# write file
write.csv(data, file = "merge_scripts/intersection_merge/parsed_intersection_merge_era_and_budé_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
