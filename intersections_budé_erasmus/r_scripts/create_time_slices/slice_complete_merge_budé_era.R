require(readr)

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
allcorr$colour <- ifelse(allcorr$Id %in% mutcorr$correspondents_id, as.character("#C3161F"), allcorr$colour)

#assign specific colour for erasmus
allcorr$colour <- ifelse(allcorr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf", as.character("#3C93AF"), allcorr$colour)

#assign specific colour for budé
allcorr$colour <- ifelse(allcorr$Id == "c0b89c75-45b8-4b04-bfd7-25bfe9ed040b", as.character("#D5AB5B"), allcorr$colour)

# ------------------------------
# subset letters for 1484
letters1484 <- subset(allepp, send_date_year1 == 1484)

# subset correspondents for 1484
corr1484 <- subset(allcorr, allcorr$Id %in% letters1484$Source | allcorr$Id %in% letters1484$Target)

# write file for letters
write.csv(letters1484, file = "merge_scripts/complete_merge/time_slice_1484_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1484, file = "merge_scripts/complete_merge/time_slice_1484_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
# ------------------------------
# subset letters for 1487
letters1487 <- subset(allepp, send_date_year1 == 1487)

# subset correspondents for 1487
corr1487 <- subset(allcorr, allcorr$Id %in% letters1487$Source | allcorr$Id %in% letters1487$Target)

# write file for letters
write.csv(letters1487, file = "merge_scripts/complete_merge/time_slice_1487_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1487, file = "merge_scripts/complete_merge/time_slice_1487_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1488
letters1488 <- subset(allepp, send_date_year1 == 1488)

# subset correspondents for 1488
corr1488 <- subset(allcorr, allcorr$Id %in% letters1488$Source | allcorr$Id %in% letters1488$Target)

# write file for letters
write.csv(letters1488, file = "merge_scripts/complete_merge/time_slice_1488_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1488, file = "merge_scripts/complete_merge/time_slice_1488_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1489
letters1489 <- subset(allepp, send_date_year1 == 1489)

# subset correspondents for 1489
corr1489 <- subset(allcorr, allcorr$Id %in% letters1489$Source | allcorr$Id %in% letters1489$Target)

# write file for letters
write.csv(letters1489, file = "merge_scripts/complete_merge/time_slice_1489_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1489, file = "merge_scripts/complete_merge/time_slice_1489_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1493
letters1493 <- subset(allepp, send_date_year1 == 1493)

# subset correspondents for 1493
corr1493 <- subset(allcorr, allcorr$Id %in% letters1493$Source | allcorr$Id %in% letters1493$Target)

# write file for letters
write.csv(letters1493, file = "merge_scripts/complete_merge/time_slice_1493_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1493, file = "merge_scripts/complete_merge/time_slice_1493_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1494
letters1494 <- subset(allepp, send_date_year1 == 1494)

# subset correspondents for 1494
corr1494 <- subset(allcorr, allcorr$Id %in% letters1494$Source | allcorr$Id %in% letters1494$Target)

# write file for letters
write.csv(letters1494, file = "merge_scripts/complete_merge/time_slice_1494_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1494, file = "merge_scripts/complete_merge/time_slice_1494_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1495
letters1495 <- subset(allepp, send_date_year1 == 1495)

# subset correspondents for 1495
corr1495 <- subset(allcorr, allcorr$Id %in% letters1495$Source | allcorr$Id %in% letters1495$Target)

# write file for letters
write.csv(letters1495, file = "merge_scripts/complete_merge/time_slice_1495_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1495, file = "merge_scripts/complete_merge/time_slice_1495_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1496
letters1496 <- subset(allepp, send_date_year1 == 1496)

# subset correspondents for 1496
corr1496 <- subset(allcorr, allcorr$Id %in% letters1496$Source | allcorr$Id %in% letters1496$Target)

# write file for letters
write.csv(letters1496, file = "merge_scripts/complete_merge/time_slice_1496_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1496, file = "merge_scripts/complete_merge/time_slice_1496_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1497
letters1497 <- subset(allepp, send_date_year1 == 1497)

# subset correspondents for 1497
corr1497 <- subset(allcorr, allcorr$Id %in% letters1497$Source | allcorr$Id %in% letters1497$Target)

# write file for letters
write.csv(letters1497, file = "merge_scripts/complete_merge/time_slice_1497_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1497, file = "merge_scripts/complete_merge/time_slice_1497_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1498
letters1498 <- subset(allepp, send_date_year1 == 1498)

# subset correspondents for 1498
corr1498 <- subset(allcorr, allcorr$Id %in% letters1498$Source | allcorr$Id %in% letters1498$Target)

# write file for letters
write.csv(letters1498, file = "merge_scripts/complete_merge/time_slice_1498_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1498, file = "merge_scripts/complete_merge/time_slice_1498_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
# ------------------------------
# subset letters for 1499
letters1499 <- subset(allepp, send_date_year1 == 1499)

# subset correspondents for 1499
corr1499 <- subset(allcorr, allcorr$Id %in% letters1499$Source | allcorr$Id %in% letters1499$Target)

# write file for letters
write.csv(letters1499, file = "merge_scripts/complete_merge/time_slice_1499_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1499, file = "merge_scripts/complete_merge/time_slice_1499_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1500
letters1500 <- subset(allepp, send_date_year1 == 1500)

# subset correspondents for 1500
corr1500 <- subset(allcorr, allcorr$Id %in% letters1500$Source | allcorr$Id %in% letters1500$Target)

# write file for letters
write.csv(letters1500, file = "merge_scripts/complete_merge/time_slice_1500_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1500, file = "merge_scripts/complete_merge/time_slice_1500_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1501
letters1501 <- subset(allepp, send_date_year1 == 1501)

# subset correspondents for 1501
corr1501 <- subset(allcorr, allcorr$Id %in% letters1501$Source | allcorr$Id %in% letters1501$Target)

# write file for letters
write.csv(letters1501, file = "merge_scripts/complete_merge/time_slice_1501_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1501, file = "merge_scripts/complete_merge/time_slice_1501_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
# ------------------------------
# subset letters for 1502
letters1502 <- subset(allepp, send_date_year1 == 1502)

# subset correspondents for 1502
corr1502 <- subset(allcorr, allcorr$Id %in% letters1502$Source | allcorr$Id %in% letters1502$Target)

# write file for letters
write.csv(letters1502, file = "merge_scripts/complete_merge/time_slice_1502_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1502, file = "merge_scripts/complete_merge/time_slice_1502_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1503
letters1503 <- subset(allepp, send_date_year1 == 1503)

# subset correspondents for 1503
corr1503 <- subset(allcorr, allcorr$Id %in% letters1503$Source | allcorr$Id %in% letters1503$Target)

# write file for letters
write.csv(letters1503, file = "merge_scripts/complete_merge/time_slice_1503_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1503, file = "merge_scripts/complete_merge/time_slice_1503_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1504
letters1504 <- subset(allepp, send_date_year1 == 1504)

# subset correspondents for 1504
corr1504 <- subset(allcorr, allcorr$Id %in% letters1504$Source | allcorr$Id %in% letters1504$Target)

# write file for letters
write.csv(letters1504, file = "merge_scripts/complete_merge/time_slice_1504_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1504, file = "merge_scripts/complete_merge/time_slice_1504_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1505
letters1505 <- subset(allepp, send_date_year1 == 1505)

# subset correspondents for 1505
corr1505 <- subset(allcorr, allcorr$Id %in% letters1505$Source | allcorr$Id %in% letters1505$Target)

# write file for letters
write.csv(letters1505, file = "merge_scripts/complete_merge/time_slice_1505_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1505, file = "merge_scripts/complete_merge/time_slice_1505_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1506
letters1506 <- subset(allepp, send_date_year1 == 1506)

# subset correspondents for 1506
corr1506 <- subset(allcorr, allcorr$Id %in% letters1506$Source | allcorr$Id %in% letters1506$Target)

# write file for letters
write.csv(letters1506, file = "merge_scripts/complete_merge/time_slice_1506_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1506, file = "merge_scripts/complete_merge/time_slice_1506_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1507
letters1507 <- subset(allepp, send_date_year1 == 1507)

# subset correspondents for 1507
corr1507 <- subset(allcorr, allcorr$Id %in% letters1507$Source | allcorr$Id %in% letters1507$Target)

# write file for letters
write.csv(letters1507, file = "merge_scripts/complete_merge/time_slice_1507_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1507, file = "merge_scripts/complete_merge/time_slice_1507_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
# ------------------------------
# subset letters for 1508
letters1508 <- subset(allepp, send_date_year1 == 1508)

# subset correspondents for 1508
corr1508 <- subset(allcorr, allcorr$Id %in% letters1508$Source | allcorr$Id %in% letters1508$Target)

# write file for letters
write.csv(letters1508, file = "merge_scripts/complete_merge/time_slice_1508_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1508, file = "merge_scripts/complete_merge/time_slice_1508_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1509
letters1509 <- subset(allepp, send_date_year1 == 1509)

# subset correspondents for 1509
corr1509 <- subset(allcorr, allcorr$Id %in% letters1509$Source | allcorr$Id %in% letters1509$Target)

# write file for letters
write.csv(letters1509, file = "merge_scripts/complete_merge/time_slice_1509_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1509, file = "merge_scripts/complete_merge/time_slice_1509_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1510
letters1510 <- subset(allepp, send_date_year1 == 1510)

# subset correspondents for 1510
corr1510 <- subset(allcorr, allcorr$Id %in% letters1510$Source | allcorr$Id %in% letters1510$Target)

# write file for letters
write.csv(letters1510, file = "merge_scripts/complete_merge/time_slice_1510_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1510, file = "merge_scripts/complete_merge/time_slice_1510_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1511
letters1511 <- subset(allepp, send_date_year1 == 1511)

# subset correspondents for 1511
corr1511 <- subset(allcorr, allcorr$Id %in% letters1511$Source | allcorr$Id %in% letters1511$Target)

# write file for letters
write.csv(letters1511, file = "merge_scripts/complete_merge/time_slice_1511_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1511, file = "merge_scripts/complete_merge/time_slice_1511_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1512
letters1512 <- subset(allepp, send_date_year1 == 1512)

# subset correspondents for 1512
corr1512 <- subset(allcorr, allcorr$Id %in% letters1512$Source | allcorr$Id %in% letters1512$Target)

# write file for letters
write.csv(letters1512, file = "merge_scripts/complete_merge/time_slice_1512_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1512, file = "merge_scripts/complete_merge/time_slice_1512_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1513
letters1513 <- subset(allepp, send_date_year1 == 1513)

# subset correspondents for 1513
corr1513 <- subset(allcorr, allcorr$Id %in% letters1513$Source | allcorr$Id %in% letters1513$Target)

# write file for letters
write.csv(letters1513, file = "merge_scripts/complete_merge/time_slice_1513_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1513, file = "merge_scripts/complete_merge/time_slice_1513_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1514
letters1514 <- subset(allepp, send_date_year1 == 1514)

# subset correspondents for 1514
corr1514 <- subset(allcorr, allcorr$Id %in% letters1514$Source | allcorr$Id %in% letters1514$Target)

# write file for letters
write.csv(letters1514, file = "merge_scripts/complete_merge/time_slice_1514_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1514, file = "merge_scripts/complete_merge/time_slice_1514_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1515
letters1515 <- subset(allepp, send_date_year1 == 1515)

# subset correspondents for 1515
corr1515 <- subset(allcorr, allcorr$Id %in% letters1515$Source | allcorr$Id %in% letters1515$Target)

# write file for letters
write.csv(letters1515, file = "merge_scripts/complete_merge/time_slice_1515_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1515, file = "merge_scripts/complete_merge/time_slice_1515_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1516
letters1516 <- subset(allepp, send_date_year1 == 1516)

# subset correspondents for 1516
corr1516 <- subset(allcorr, allcorr$Id %in% letters1516$Source | allcorr$Id %in% letters1516$Target)

# write file for letters
write.csv(letters1516, file = "merge_scripts/complete_merge/time_slice_1516_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1516, file = "merge_scripts/complete_merge/time_slice_1516_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1517
letters1517 <- subset(allepp, send_date_year1 == 1517)

# subset correspondents for 1517
corr1517 <- subset(allcorr, allcorr$Id %in% letters1517$Source | allcorr$Id %in% letters1517$Target)

# write file for letters
write.csv(letters1517, file = "merge_scripts/complete_merge/time_slice_1517_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1517, file = "merge_scripts/complete_merge/time_slice_1517_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1518
letters1518 <- subset(allepp, send_date_year1 == 1518)

# subset correspondents for 1518
corr1518 <- subset(allcorr, allcorr$Id %in% letters1518$Source | allcorr$Id %in% letters1518$Target)

# write file for letters
write.csv(letters1518, file = "merge_scripts/complete_merge/time_slice_1518_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1518, file = "merge_scripts/complete_merge/time_slice_1518_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1519
letters1519 <- subset(allepp, send_date_year1 == 1519)

# subset correspondents for 1519
corr1519 <- subset(allcorr, allcorr$Id %in% letters1519$Source | allcorr$Id %in% letters1519$Target)

# write file for letters
write.csv(letters1519, file = "merge_scripts/complete_merge/time_slice_1519_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1519, file = "merge_scripts/complete_merge/time_slice_1519_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1520
letters1520 <- subset(allepp, send_date_year1 == 1520)

# subset correspondents for 1520
corr1520 <- subset(allcorr, allcorr$Id %in% letters1520$Source | allcorr$Id %in% letters1520$Target)

# write file for letters
write.csv(letters1520, file = "merge_scripts/complete_merge/time_slice_1520_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1520, file = "merge_scripts/complete_merge/time_slice_1520_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1521
letters1521 <- subset(allepp, send_date_year1 == 1521)

# subset correspondents for 1521
corr1521 <- subset(allcorr, allcorr$Id %in% letters1521$Source | allcorr$Id %in% letters1521$Target)

# write file for letters
write.csv(letters1521, file = "merge_scripts/complete_merge/time_slice_1521_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1521, file = "merge_scripts/complete_merge/time_slice_1521_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1522
letters1522 <- subset(allepp, send_date_year1 == 1522)

# subset correspondents for 1522
corr1522 <- subset(allcorr, allcorr$Id %in% letters1522$Source | allcorr$Id %in% letters1522$Target)

# write file for letters
write.csv(letters1522, file = "merge_scripts/complete_merge/time_slice_1522_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1522, file = "merge_scripts/complete_merge/time_slice_1522_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1523
letters1523 <- subset(allepp, send_date_year1 == 1523)

# subset correspondents for 1523
corr1523 <- subset(allcorr, allcorr$Id %in% letters1523$Source | allcorr$Id %in% letters1523$Target)

# write file for letters
write.csv(letters1523, file = "merge_scripts/complete_merge/time_slice_1523_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1523, file = "merge_scripts/complete_merge/time_slice_1523_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1524
letters1524 <- subset(allepp, send_date_year1 == 1524)

# subset correspondents for 1524
corr1524 <- subset(allcorr, allcorr$Id %in% letters1524$Source | allcorr$Id %in% letters1524$Target)

# write file for letters
write.csv(letters1524, file = "merge_scripts/complete_merge/time_slice_1524_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1524, file = "merge_scripts/complete_merge/time_slice_1524_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1525
letters1525 <- subset(allepp, send_date_year1 == 1525)

# subset correspondents for 1525
corr1525 <- subset(allcorr, allcorr$Id %in% letters1525$Source | allcorr$Id %in% letters1525$Target)

# write file for letters
write.csv(letters1525, file = "merge_scripts/complete_merge/time_slice_1525_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1525, file = "merge_scripts/complete_merge/time_slice_1525_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1526
letters1526 <- subset(allepp, send_date_year1 == 1526)

# subset correspondents for 1526
corr1526 <- subset(allcorr, allcorr$Id %in% letters1526$Source | allcorr$Id %in% letters1526$Target)

# write file for letters
write.csv(letters1526, file = "merge_scripts/complete_merge/time_slice_1526_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1526, file = "merge_scripts/complete_merge/time_slice_1526_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1527
letters1527 <- subset(allepp, send_date_year1 == 1527)

# subset correspondents for 1527
corr1527 <- subset(allcorr, allcorr$Id %in% letters1527$Source | allcorr$Id %in% letters1527$Target)

# write file for letters
write.csv(letters1527, file = "merge_scripts/complete_merge/time_slice_1527_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1527, file = "merge_scripts/complete_merge/time_slice_1527_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1528
letters1528 <- subset(allepp, send_date_year1 == 1528)

# subset correspondents for 1528
corr1528 <- subset(allcorr, allcorr$Id %in% letters1528$Source | allcorr$Id %in% letters1528$Target)

# write file for letters
write.csv(letters1528, file = "merge_scripts/complete_merge/time_slice_1528_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1528, file = "merge_scripts/complete_merge/time_slice_1528_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1529
letters1529 <- subset(allepp, send_date_year1 == 1529)

# subset correspondents for 1529
corr1529 <- subset(allcorr, allcorr$Id %in% letters1529$Source | allcorr$Id %in% letters1529$Target)

# write file for letters
write.csv(letters1529, file = "merge_scripts/complete_merge/time_slice_1529_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1529, file = "merge_scripts/complete_merge/time_slice_1529_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1530
letters1530 <- subset(allepp, send_date_year1 == 1530)

# subset correspondents for 1530
corr1530 <- subset(allcorr, allcorr$Id %in% letters1530$Source | allcorr$Id %in% letters1530$Target)

# write file for letters
write.csv(letters1530, file = "merge_scripts/complete_merge/time_slice_1530_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1530, file = "merge_scripts/complete_merge/time_slice_1530_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1531
letters1531 <- subset(allepp, send_date_year1 == 1531)

# subset correspondents for 1531
corr1531 <- subset(allcorr, allcorr$Id %in% letters1531$Source | allcorr$Id %in% letters1531$Target)

# write file for letters
write.csv(letters1531, file = "merge_scripts/complete_merge/time_slice_1531_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1531, file = "merge_scripts/complete_merge/time_slice_1531_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1532
letters1532 <- subset(allepp, send_date_year1 == 1532)

# subset correspondents for 1532
corr1532 <- subset(allcorr, allcorr$Id %in% letters1532$Source | allcorr$Id %in% letters1532$Target)

# write file for letters
write.csv(letters1532, file = "merge_scripts/complete_merge/time_slice_1532_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1532, file = "merge_scripts/complete_merge/time_slice_1532_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1533
letters1533 <- subset(allepp, send_date_year1 == 1533)

# subset correspondents for 1533
corr1533 <- subset(allcorr, allcorr$Id %in% letters1533$Source | allcorr$Id %in% letters1533$Target)

# write file for letters
write.csv(letters1533, file = "merge_scripts/complete_merge/time_slice_1533_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1533, file = "merge_scripts/complete_merge/time_slice_1533_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1534
letters1534 <- subset(allepp, send_date_year1 == 1534)

# subset correspondents for 1534
corr1534 <- subset(allcorr, allcorr$Id %in% letters1534$Source | allcorr$Id %in% letters1534$Target)

# write file for letters
write.csv(letters1534, file = "merge_scripts/complete_merge/time_slice_1534_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1534, file = "merge_scripts/complete_merge/time_slice_1534_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1535
letters1535 <- subset(allepp, send_date_year1 == 1535)

# subset correspondents for 1535
corr1535 <- subset(allcorr, allcorr$Id %in% letters1535$Source | allcorr$Id %in% letters1535$Target)

# write file for letters
write.csv(letters1535, file = "merge_scripts/complete_merge/time_slice_1535_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1535, file = "merge_scripts/complete_merge/time_slice_1535_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1536
letters1536 <- subset(allepp, send_date_year1 == 1536)

# subset correspondents for 1536
corr1536 <- subset(allcorr, allcorr$Id %in% letters1536$Source | allcorr$Id %in% letters1536$Target)

# write file for letters
write.csv(letters1536, file = "merge_scripts/complete_merge/time_slice_1536_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1536, file = "merge_scripts/complete_merge/time_slice_1536_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
# subset letters for 1539
letters1539 <- subset(allepp, send_date_year1 == 1539)

# subset correspondents for 1539
corr1539 <- subset(allcorr, allcorr$Id %in% letters1539$Source | allcorr$Id %in% letters1539$Target)

# write file for letters
write.csv(letters1539, file = "merge_scripts/complete_merge/time_slice_1539_complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", row.names=FALSE)

# write file for correspondents
write.csv(corr1539, file = "merge_scripts/complete_merge/time_slice_1539_complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", row.names=FALSE)
#-------------------------------
