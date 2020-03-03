require(readr)
require(tidyverse)

# set working directory
getwd()
setwd("../query_results/")

# === Data Preparation ===

# read data for no corr per loc writing to era_
data_corr_per_loc_sent_to_era<-read.csv("no_corr_per_loc/no_corr_per_loc_writing_to_era_with_geocoordinates.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data for no epp per loc sent to era
data_epp_sent_to_era <-read.csv("no_epp_per_loc/no_epp_per_loc_sent_to_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# subset data_corr_per_loc_sent_to_era outliers
data_corr_per_loc_sent_to_era_outlier <- subset(data_corr_per_loc_sent_to_era, data_corr_per_loc_sent_to_era$Number.of.correspondents.who.wrote.from.this.location.letters.to.Erasmus > 6)

# subset data_epp_sent_to_era outliers
data_epp_sent_to_era_outlier <- subset(data_epp_sent_to_era, data_epp_sent_to_era$Number.of.letters.sent.from.this.location.to.Erasmus > 8.5)


# === Data Query ===

# subset locations in data_corr_per_loc_sent_to_era_outlier that are in data_epp_sent_to_era_outlier
data_corr_per_loc_sent_to_era_in_epp_sent_to_era_outlier <- subset(data_corr_per_loc_sent_to_era_outlier, data_corr_per_loc_sent_to_era_outlier$Location.Name %in% data_epp_sent_to_era_outlier$Location.Name)

# subset locations in data_corr_per_loc_sent_to_era_outlier that are not in data_epp_sent_to_era_outlier
data_corr_per_loc_sent_to_era_not_in_epp_sent_to_era_outlier <- subset(data_corr_per_loc_sent_to_era_outlier, !data_corr_per_loc_sent_to_era_outlier$Location.Name %in% data_epp_sent_to_era_outlier$Location.Name)

# subset locations in data_epp_sent_to_era_outlier that are in data_corr_per_loc_sent_to_era_outlier
data_epp_sent_to_era_in_corr_per_loc_sent_to_era_outlier <- subset(data_epp_sent_to_era_outlier, data_epp_sent_to_era_outlier$Location.Name %in% data_corr_per_loc_sent_to_era_outlier$Location.Name)

# subset locations in data_epp_sent_to_era_outlier that are not in data_corr_per_loc_sent_to_era_outlier
data_epp_sent_to_era_not_in_corr_per_loc_sent_to_era_outlier <- subset(data_epp_sent_to_era_outlier, !data_epp_sent_to_era_outlier$Location.Name %in% data_corr_per_loc_sent_to_era_outlier$Location.Name)















