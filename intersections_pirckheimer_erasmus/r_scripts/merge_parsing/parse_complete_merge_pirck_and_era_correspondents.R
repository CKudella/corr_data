require(readr)
require(ggplot2)
library(readr)
library(tidyverse)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data for all correspondents
data<-read.csv("merge_scripts/complete_merge/complete_merge_pirck_and_era_correspondents.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data for mutual correspondents
mutcorr<-read.csv("intersection_overview/id_and_names_of_mut_corr_era_pirck.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# cut uncessary label parts from Label column
data$Label <- gsub("\\b(\\W+COE+.*)", "", data$Label)
data$Label <- gsub("^(\\W+E)", "E", data$Label)

# add colour for all correspondents
data$colour <- "#525252"

# add colour column for mutual correspondents to be used with the "give colour to nodes" plugin for gephi
data$colour <- ifelse(data$Id %in% mutcorr$correspondents_id, as.character("#fdb863"), data$colour)

#assign specific colour for erasmus
data$colour <- ifelse(data$Id == "erasmus_desiderius_viaf_95982394", as.character("#e66101"), data$colour)

#assign specific colour for pirckheimer
data$colour <- ifelse(data$Id == "pirckheimer_willibald_viaf_27173507", as.character("#5e3c99"), data$colour)

# write file
write.csv(data, file = "merge_scripts/complete_merge/parsed_complete_merge_pirck_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
