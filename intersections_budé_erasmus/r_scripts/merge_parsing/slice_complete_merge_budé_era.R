require(readr)
require(ggplot2)
library(readr)
library(tidyverse)
library(ggplot2)

# set working directory
getwd()
setwd("../query_results/")

# read data for all correspondents
allcorr<-read.csv("merge_scripts/complete_merge/complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data for all letters
allepp<-read.csv("merge_scripts/complete_merge/complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data for mutual correspondents
mutcorr<-read.csv("intersection_overview/id_and_names_of_mut_corr_era_budé.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# cut uncessary label parts from Label column
allcorr$Label <- gsub("\\b(\\W+COE+.*)", "", allcorr$Label)
allcorr$Label <- gsub("^(\\W+E)", "E", allcorr$Label)

# add colour for all correspondents
allcorr$colour <- "#525252"

# add colour column for mutual correspondents to be used with the "give colour to nodes" plugin for gephi
allcorr$colour <- ifelse(allcorr$Id %in% mutcorr$correspondents_id, as.character("#fdb863"), allcorr$colour)

#assign specific colour for erasmus
allcorr$colour <- ifelse(allcorr$Id == "erasmus_desiderius_viaf_95982394", as.character("#e66101"), allcorr$colour)

#assign specific colour for budé
allcorr$colour <- ifelse(allcorr$Id == "budé_guillaume_viaf_105878228", as.character("#5e3c99"), allcorr$colour)

# ------------------------------
# subset letters for 1499
letters1499 <- subset(allepp, send_date_year1 == 1499)

# subset correspondents for 1499
corr1499 <- subset(allcorr, allcorr$Id %in% letters1499$Source | allcorr$Id %in% letters1499$Target)

# write file for letters
write.csv(letters1499, file = "merge_scripts/complete_merge/time_slice_1499_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1499, file = "merge_scripts/complete_merge/time_slice_1499_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1505
letters1505 <- subset(allepp, send_date_year1 == 1505)

# subset correspondents for 1505
corr1505 <- subset(allcorr, allcorr$Id %in% letters1505$Source | allcorr$Id %in% letters1505$Target)

# write file for letters
write.csv(letters1505, file = "merge_scripts/complete_merge/time_slice_1505_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1505, file = "merge_scripts/complete_merge/time_slice_1505_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1506
letters1506 <- subset(allepp, send_date_year1 == 1506)

# subset correspondents for 1506
corr1506 <- subset(allcorr, allcorr$Id %in% letters1506$Source | allcorr$Id %in% letters1506$Target)

# write file for letters
write.csv(letters1506, file = "merge_scripts/complete_merge/time_slice_1506_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1506, file = "merge_scripts/complete_merge/time_slice_1506_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1510
letters1510 <- subset(allepp, send_date_year1 == 1510)

# subset correspondents for 1510
corr1510 <- subset(allcorr, allcorr$Id %in% letters1510$Source | allcorr$Id %in% letters1510$Target)

# write file for letters
write.csv(letters1510, file = "merge_scripts/complete_merge/time_slice_1510_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1510, file = "merge_scripts/complete_merge/time_slice_1510_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1511
letters1511 <- subset(allepp, send_date_year1 == 1511)

# subset correspondents for 1511
corr1511 <- subset(allcorr, allcorr$Id %in% letters1511$Source | allcorr$Id %in% letters1511$Target)

# write file for letters
write.csv(letters1511, file = "merge_scripts/complete_merge/time_slice_1511_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1511, file = "merge_scripts/complete_merge/time_slice_1511_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1512
letters1512 <- subset(allepp, send_date_year1 == 1512)

# subset correspondents for 1512
corr1512 <- subset(allcorr, allcorr$Id %in% letters1512$Source | allcorr$Id %in% letters1512$Target)

# write file for letters
write.csv(letters1512, file = "merge_scripts/complete_merge/time_slice_1512_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1512, file = "merge_scripts/complete_merge/time_slice_1512_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1513
letters1513 <- subset(allepp, send_date_year1 == 1513)

# subset correspondents for 1513
corr1513 <- subset(allcorr, allcorr$Id %in% letters1513$Source | allcorr$Id %in% letters1513$Target)

# write file for letters
write.csv(letters1513, file = "merge_scripts/complete_merge/time_slice_1513_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1513, file = "merge_scripts/complete_merge/time_slice_1513_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1514
letters1514 <- subset(allepp, send_date_year1 == 1514)

# subset correspondents for 1514
corr1514 <- subset(allcorr, allcorr$Id %in% letters1514$Source | allcorr$Id %in% letters1514$Target)

# write file for letters
write.csv(letters1514, file = "merge_scripts/complete_merge/time_slice_1514_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1514, file = "merge_scripts/complete_merge/time_slice_1514_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1515
letters1515 <- subset(allepp, send_date_year1 == 1515)

# subset correspondents for 1515
corr1515 <- subset(allcorr, allcorr$Id %in% letters1515$Source | allcorr$Id %in% letters1515$Target)

# write file for letters
write.csv(letters1515, file = "merge_scripts/complete_merge/time_slice_1515_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1515, file = "merge_scripts/complete_merge/time_slice_1515_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1516
letters1516 <- subset(allepp, send_date_year1 == 1516)

# subset correspondents for 1516
corr1516 <- subset(allcorr, allcorr$Id %in% letters1516$Source | allcorr$Id %in% letters1516$Target)

# write file for letters
write.csv(letters1516, file = "merge_scripts/complete_merge/time_slice_1516_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1516, file = "merge_scripts/complete_merge/time_slice_1516_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1517
letters1517 <- subset(allepp, send_date_year1 == 1517)

# subset correspondents for 1517
corr1517 <- subset(allcorr, allcorr$Id %in% letters1517$Source | allcorr$Id %in% letters1517$Target)

# write file for letters
write.csv(letters1517, file = "merge_scripts/complete_merge/time_slice_1517_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1517, file = "merge_scripts/complete_merge/time_slice_1517_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1518
letters1518 <- subset(allepp, send_date_year1 == 1518)

# subset correspondents for 1518
corr1518 <- subset(allcorr, allcorr$Id %in% letters1518$Source | allcorr$Id %in% letters1518$Target)

# write file for letters
write.csv(letters1518, file = "merge_scripts/complete_merge/time_slice_1518_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1518, file = "merge_scripts/complete_merge/time_slice_1518_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1519
letters1519 <- subset(allepp, send_date_year1 == 1519)

# subset correspondents for 1519
corr1519 <- subset(allcorr, allcorr$Id %in% letters1519$Source | allcorr$Id %in% letters1519$Target)

# write file for letters
write.csv(letters1519, file = "merge_scripts/complete_merge/time_slice_1519_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1519, file = "merge_scripts/complete_merge/time_slice_1519_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1520
letters1520 <- subset(allepp, send_date_year1 == 1520)

# subset correspondents for 1520
corr1520 <- subset(allcorr, allcorr$Id %in% letters1520$Source | allcorr$Id %in% letters1520$Target)

# write file for letters
write.csv(letters1520, file = "merge_scripts/complete_merge/time_slice_1520_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1520, file = "merge_scripts/complete_merge/time_slice_1520_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1521
letters1521 <- subset(allepp, send_date_year1 == 1521)

# subset correspondents for 1521
corr1521 <- subset(allcorr, allcorr$Id %in% letters1521$Source | allcorr$Id %in% letters1521$Target)

# write file for letters
write.csv(letters1521, file = "merge_scripts/complete_merge/time_slice_1521_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1521, file = "merge_scripts/complete_merge/time_slice_1521_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1522
letters1522 <- subset(allepp, send_date_year1 == 1522)

# subset correspondents for 1522
corr1522 <- subset(allcorr, allcorr$Id %in% letters1522$Source | allcorr$Id %in% letters1522$Target)

# write file for letters
write.csv(letters1522, file = "merge_scripts/complete_merge/time_slice_1522_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1522, file = "merge_scripts/complete_merge/time_slice_1522_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1523
letters1523 <- subset(allepp, send_date_year1 == 1523)

# subset correspondents for 1523
corr1523 <- subset(allcorr, allcorr$Id %in% letters1523$Source | allcorr$Id %in% letters1523$Target)

# write file for letters
write.csv(letters1523, file = "merge_scripts/complete_merge/time_slice_1523_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1523, file = "merge_scripts/complete_merge/time_slice_1523_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1524
letters1524 <- subset(allepp, send_date_year1 == 1524)

# subset correspondents for 1524
corr1524 <- subset(allcorr, allcorr$Id %in% letters1524$Source | allcorr$Id %in% letters1524$Target)

# write file for letters
write.csv(letters1524, file = "merge_scripts/complete_merge/time_slice_1524_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1524, file = "merge_scripts/complete_merge/time_slice_1524_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1525
letters1525 <- subset(allepp, send_date_year1 == 1525)

# subset correspondents for 1525
corr1525 <- subset(allcorr, allcorr$Id %in% letters1525$Source | allcorr$Id %in% letters1525$Target)

# write file for letters
write.csv(letters1525, file = "merge_scripts/complete_merge/time_slice_1525_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1525, file = "merge_scripts/complete_merge/time_slice_1525_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1526
letters1526 <- subset(allepp, send_date_year1 == 1526)

# subset correspondents for 1526
corr1526 <- subset(allcorr, allcorr$Id %in% letters1526$Source | allcorr$Id %in% letters1526$Target)

# write file for letters
write.csv(letters1526, file = "merge_scripts/complete_merge/time_slice_1526_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1526, file = "merge_scripts/complete_merge/time_slice_1526_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1527
letters1527 <- subset(allepp, send_date_year1 == 1527)

# subset correspondents for 1527
corr1527 <- subset(allcorr, allcorr$Id %in% letters1527$Source | allcorr$Id %in% letters1527$Target)

# write file for letters
write.csv(letters1527, file = "merge_scripts/complete_merge/time_slice_1527_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1527, file = "merge_scripts/complete_merge/time_slice_1527_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1528
letters1528 <- subset(allepp, send_date_year1 == 1528)

# subset correspondents for 1528
corr1528 <- subset(allcorr, allcorr$Id %in% letters1528$Source | allcorr$Id %in% letters1528$Target)

# write file for letters
write.csv(letters1528, file = "merge_scripts/complete_merge/time_slice_1528_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1528, file = "merge_scripts/complete_merge/time_slice_1528_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1529
letters1529 <- subset(allepp, send_date_year1 == 1529)

# subset correspondents for 1529
corr1529 <- subset(allcorr, allcorr$Id %in% letters1529$Source | allcorr$Id %in% letters1529$Target)

# write file for letters
write.csv(letters1529, file = "merge_scripts/complete_merge/time_slice_1529_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1529, file = "merge_scripts/complete_merge/time_slice_1529_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1530
letters1530 <- subset(allepp, send_date_year1 == 1530)

# subset correspondents for 1530
corr1530 <- subset(allcorr, allcorr$Id %in% letters1530$Source | allcorr$Id %in% letters1530$Target)

# write file for letters
write.csv(letters1530, file = "merge_scripts/complete_merge/time_slice_1530_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1530, file = "merge_scripts/complete_merge/time_slice_1530_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1531
letters1531 <- subset(allepp, send_date_year1 == 1531)

# subset correspondents for 1531
corr1531 <- subset(allcorr, allcorr$Id %in% letters1531$Source | allcorr$Id %in% letters1531$Target)

# write file for letters
write.csv(letters1531, file = "merge_scripts/complete_merge/time_slice_1531_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1531, file = "merge_scripts/complete_merge/time_slice_1531_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1532
letters1532 <- subset(allepp, send_date_year1 == 1532)

# subset correspondents for 1532
corr1532 <- subset(allcorr, allcorr$Id %in% letters1532$Source | allcorr$Id %in% letters1532$Target)

# write file for letters
write.csv(letters1532, file = "merge_scripts/complete_merge/time_slice_1532_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1532, file = "merge_scripts/complete_merge/time_slice_1532_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1533
letters1533 <- subset(allepp, send_date_year1 == 1533)

# subset correspondents for 1533
corr1533 <- subset(allcorr, allcorr$Id %in% letters1533$Source | allcorr$Id %in% letters1533$Target)

# write file for letters
write.csv(letters1533, file = "merge_scripts/complete_merge/time_slice_1533_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1533, file = "merge_scripts/complete_merge/time_slice_1533_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1534
letters1534 <- subset(allepp, send_date_year1 == 1534)

# subset correspondents for 1534
corr1534 <- subset(allcorr, allcorr$Id %in% letters1534$Source | allcorr$Id %in% letters1534$Target)

# write file for letters
write.csv(letters1534, file = "merge_scripts/complete_merge/time_slice_1534_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1534, file = "merge_scripts/complete_merge/time_slice_1534_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1535
letters1535 <- subset(allepp, send_date_year1 == 1535)

# subset correspondents for 1535
corr1535 <- subset(allcorr, allcorr$Id %in% letters1535$Source | allcorr$Id %in% letters1535$Target)

# write file for letters
write.csv(letters1535, file = "merge_scripts/complete_merge/time_slice_1535_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1535, file = "merge_scripts/complete_merge/time_slice_1535_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1536
letters1536 <- subset(allepp, send_date_year1 == 1536)

# subset correspondents for 1536
corr1536 <- subset(allcorr, allcorr$Id %in% letters1536$Source | allcorr$Id %in% letters1536$Target)

# write file for letters
write.csv(letters1536, file = "merge_scripts/complete_merge/time_slice_1536_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1536, file = "merge_scripts/complete_merge/time_slice_1536_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
