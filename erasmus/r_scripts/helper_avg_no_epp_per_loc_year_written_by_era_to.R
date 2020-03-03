require(readr)
require(tidyverse)

# set working directory
getwd()
setwd("../query_results/")

# === Data Preparation ===

# read data for no epp per loc written by era to
data_epp<-read.csv("no_epp_per_loc/no_epp_per_loc_sent_by_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data for avg no epp per loc year written by era to
data_avg <-read.csv("no_epp_per_loc/avg_no_epp_per_loc_year_written_by_era_to.csv", fileEncoding="UTF-8", na.strings=c("NULL"))


# subset data_avg outliers
data_avg_outlier <- subset(data_avg, data_avg$Average.Number.of.Letters.written.by.Erasmus.to.this.location.per.year > 3)

# subset data_epp outliers
data_epp_outlier <- subset(data_epp, data_epp$Number.of.letters.sent.to.this.location.from.Erasmus > 13.5)


# === Data Query ===

# subset locations in data_avg_outliers that are in data_epp_outliers
data_avg_in_epp <- subset(data_avg_outlier, data_avg_outlier$Location.Name %in% data_epp_outlier$Location.Name)

# subset locations in data_avg_outliers that are not in data_epp_outliers
data_avg_not_in_epp <- subset(data_avg_outlier, !data_avg_outlier$Location.Name %in% data_epp_outlier$Location.Name)

# subset locations in data_epp_outliers that are in data_avg_outliers
data_epp_in_avg <- subset(data_epp_outlier, data_epp_outlier$Location.Name %in% data_avg_outlier$Location.Name)

# subset locations in data_epp_outliers that are not in data_avg_outliers
data_epp_not_in_avg <- subset(data_epp_outlier, !data_epp_outlier$Location.Name %in% data_avg_outlier$Location.Name)








