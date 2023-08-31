require(tidyverse)

# set working directory
getwd()
setwd("../query_results/")

# === Data Preparation ===

# read data for no epp per loc sent to era
data_epp_sent_to_era <-read.csv("no_epp_per_loc/no_epp_per_loc_sent_to_era.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data for no epp per loc year written by era to
data_epp_sent_by_era_to <-read.csv("no_epp_per_loc/no_epp_per_loc_sent_by_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# subset epp_sent_to_era outliers
data_epp_sent_to_era_outlier <- subset(data_epp_sent_to_era, data_epp_sent_to_era$Number.of.letters.sent.from.this.location.to.Erasmus > 8.5)

# subset epp_sent_by_era_to outliers
data_epp_sent_by_era_to_outlier <- subset(data_epp_sent_by_era_to, data_epp_sent_by_era_to$Number.of.letters.sent.to.this.location.from.Erasmus > 13.5)


# === Data Query ===

# subset locations in data_epp_sent_to_era_outlier that are in data_epp_sent_by_era_to_outlier
data_epp_sent_to_era_in_epp_sent_by_era_to <- subset(data_epp_sent_to_era_outlier, data_epp_sent_to_era_outlier$Location.Name %in% data_epp_sent_by_era_to_outlier$Location.Name)

# subset locations in data_epp_sent_to_era_outlier that are not in data_epp_sent_by_era_to_outlier
data_epp_sent_to_era_not_in_epp_sent_by_era_to <- subset(data_epp_sent_to_era_outlier, !data_epp_sent_to_era_outlier$Location.Name %in% data_epp_sent_by_era_to_outlier$Location.Name)

# subset locations in  data_epp_sent_by_era_to_outlier that are in data_epp_sent_to_era_outlier
data_epp_sent_by_era_to_in_epp_sent_to_era <- subset(data_epp_sent_by_era_to_outlier, data_epp_sent_by_era_to_outlier$Location.Name %in% data_epp_sent_to_era_outlier$Location.Name)

# subset locations in  data_epp_sent_by_era_to_outlier that are in data_epp_sent_to_era_outlier
data_epp_sent_by_era_to_not_in_epp_sent_to_era <- subset(data_epp_sent_by_era_to_outlier, !data_epp_sent_by_era_to_outlier$Location.Name %in% data_epp_sent_to_era_outlier$Location.Name)











