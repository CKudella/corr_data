require(readr)
require(tidyverse)

# set working directory
getwd()
setwd("../query_results/")

# === Data Preparation ===

# read data for no corr per loc receiving from era
data_corr_per_loc_rec_from_era<-read.csv("no_corr_per_loc/no_corr_per_loc_receiving_from_era_with_geocoordinates.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data for no epp per loc sent by era to
data_epp_sent_by_era_to <-read.csv("no_epp_per_loc/no_epp_per_loc_sent_by_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# subset data_corr_per_loc_rec_from_era
data_corr_per_loc_rec_from_era_outlier <- subset(data_corr_per_loc_rec_from_era, data_corr_per_loc_rec_from_era$Number.of.correspondents.who.received.at.this.location.letters.from.Erasmus > 6)

# subset 
data_epp_sent_by_era_to_outlier <- subset(data_epp_sent_by_era_to, data_epp_sent_by_era_to$Number.of.letters.sent.to.this.location.from.Erasmus > 13.5)


# === Data Query ===

# subset locations in data_corr_per_loc_rec_from_era_outlier that are in data_epp_sent_by_era_to_outlier
data_corr_per_loc_rec_from_era_in_epp_sent_by_era_to_outlier <- subset(data_corr_per_loc_rec_from_era_outlier, data_corr_per_loc_rec_from_era_outlier$Location.Name %in% data_epp_sent_by_era_to_outlier$Location.Name)

# subset locations in data_corr_per_loc_rec_from_era_outlier that are not in data_epp_sent_by_era_to_outlier
data_corr_per_loc_rec_from_era_not_in_epp_sent_by_era_to_outlier <- subset(data_corr_per_loc_rec_from_era_outlier, !data_corr_per_loc_rec_from_era_outlier$Location.Name %in% data_epp_sent_by_era_to_outlier$Location.Name)

# subset locations in data_epp_sent_by_era_to_outlier that are in data_corr_per_loc_rec_from_era_outlier
data_epp_sent_by_era_to_in_corr_per_loc_rec_from_era_outlier <- subset(data_epp_sent_by_era_to_outlier, data_epp_sent_by_era_to_outlier$Location.Name %in% data_corr_per_loc_rec_from_era_outlier$Location.Name)

# subset locations in data_epp_sent_by_era_to_outlier that are not in data_corr_per_loc_rec_from_era_outlier
data_epp_sent_by_era_to_not_in_corr_per_loc_rec_from_era_outlier <- subset(data_epp_sent_by_era_to_outlier, !data_epp_sent_by_era_to_outlier$Location.Name %in% data_corr_per_loc_rec_from_era_outlier$Location.Name)
















