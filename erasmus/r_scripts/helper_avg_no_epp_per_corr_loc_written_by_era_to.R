require(tidyverse)

# set working directory
getwd()
setwd("../query_results/")

# === Data Preparation ===

# read data for no epp per loc written by era to
data_epp <-read.csv("no_epp_per_loc/no_epp_per_loc_sent_by_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data for avg no epp per corr loc written by era to
data_avg <-read.csv("no_epp_per_loc/avg_no_epp_per_corr_loc_written_by_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data for no corr per loc receiving from era
data_corr <-read.csv("no_corr_per_loc/no_corr_per_loc_receiving_from_era_with_geocoordinates.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# subset data_avg outliers
data_avg_outlier <- subset(data_avg, data_avg$Average.Number.of.letters.per.correspondent > 5)

# subset data_epp outliers
data_epp_outlier <- subset(data_epp, data_epp$Number.of.letters.sent.to.this.location.from.Erasmus > 13.5)

# subset data_corr outliers
data_corr_outlier <- subset(data_corr, data_corr$Number.of.correspondents.who.received.at.this.location.letters.from.Erasmus >= 6)

# === Data Query ===

# subset locations in data_avg_outliers that are in both data_epp_outliers and data_corr_outliers
data_avg_in_epp_and_in_corr <- subset(data_avg_outlier, data_avg_outlier$Location.Name %in% data_epp_outlier$Location.Name & data_avg_outlier$Location.Name %in% data_corr_outlier$Location.Name)

# subset locations in data_avg_outliers that are in data_epp_outliers and not in data_corr_outliers
data_avg_in_epp_and_not_in_corr <- subset(data_avg_outlier, data_avg_outlier$Location.Name %in% data_epp_outlier$Location.Name & !data_avg_outlier$Location.Name %in% data_corr_outlier$Location.Name)

# subset locations in data_avg_outliers that are not in data_epp_outliers but in data_corr_outliers
data_avg_not_in_epp_but_in_corr <- subset(data_avg_outlier, !data_avg_outlier$Location.Name %in% data_epp_outlier$Location.Name & data_avg_outlier$Location.Name %in% data_corr_outlier$Location.Name)

# subset locations in data_avg_outliers that are not in data_epp_outliers
data_avg_not_in_epp <- subset(data_avg_outlier, !data_avg_outlier$Location.Name %in% data_epp_outlier$Location.Name)

# subset locations in data_avg_outliers that are in data_epp_outliers
data_avg_in_epp <- subset(data_avg_outlier, data_avg_outlier$Location.Name %in% data_epp_outlier$Location.Name)

# subset locations in data_avg_outliers that are not in data_corr_outliers
data_avg_not_in_corr <- subset(data_avg_outlier, !data_avg_outlier$Location.Name %in% data_corr_outlier$Location.Name)

# subset locations in data_avg_outliers that are in data_corr_outliers
data_avg_in_corr <- subset(data_avg_outlier, data_avg_outlier$Location.Name %in% data_corr_outlier$Location.Name)

# subset locations in data_avg_outliers that are not in both data_epp_outliers and data_corr_outliers
data_avg_not_in_epp_not_in_corr <- subset(data_avg_outlier, !data_avg_outlier$Location.Name %in% data_epp_outlier$Location.Name & !data_avg_outlier$Location.Name %in% data_corr_outlier$Location.Name)





