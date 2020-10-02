require(readr)
require(lubridate)
require(ndtv)
require(tsna)
library(readr)
library(lubridate)
library(ndtv)
library(tsna)


# set working directory
getwd()
setwd("../query_results/")

# read data for mutual correspondents
mutcorr<-read.csv("merge_scripts/intersection_merge/intersection_merge_era_and_budé_correspondents.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data for letters exchanged between erasmus, budé, and their mutual correspondents
mutepp<-read.csv("merge_scripts/intersection_merge/intersection_merge_era_and_budé_letters_corr_as_nodes.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# cut uncessary label parts from Label column
mutcorr$Label <- gsub("\\b(\\W+COE+.*)", "", mutcorr$Label)
mutcorr$Label <- gsub("^(\\W+E)", "E", mutcorr$Label)

# add colour column for mutual correspondents to be used with the "give colour to nodes" plugin for gephi
mutcorr$colour <- "#fdb863"

#assign specific colour for erasmus
mutcorr$colour <- ifelse(mutcorr$Id == "erasmus_desiderius_viaf_95982394", as.character("#e66101"), mutcorr$colour)

#assign specific colour for budé
mutcorr$colour <- ifelse(mutcorr$Id == "budé_guillaume_viaf_105878228", as.character("#5e3c99"), mutcorr$colour)

# assign colours to edges according to the source
mutepp$colour <- mutcorr$colour[match(mutepp$Source,mutcorr$Id)]

# set send_date_computable1 asDate
mutepp$send_date_computable1 <- as.Date(mutepp$send_date_computable1, format="%Y-%m-%d")

# extract start year as onset
mutepp$onset <- year(mutepp$send_date_computable1)

# set send_date_computable2 asDate
mutepp$send_date_computable2 <- as.Date(mutepp$send_date_computable2, format="%Y-%m-%d")

# extract end year as terminus
mutepp$terminus <- year(mutepp$send_date_computable2)

# replace the string with a numeric id and convert to numeric
mutcorr$clearId <- mutcorr$Id
mutcorr$Id <- as.factor(mutcorr$Id)
levels(mutcorr$Id) <- 1:length(levels(mutcorr$Id))
mutcorr$Id <- as.numeric(mutcorr$Id)

# rename source column as tail
colnames(mutepp)[colnames(mutepp) == 'Source'] <- 'tail'

# replace the string with a numeric id and convert to numeric
mutepp$tail <- mutcorr$Id[match(mutepp$tail,mutcorr$clearId)]
mutepp$tail <- as.numeric(mutepp$tail)

# rename target column as head
colnames(mutepp)[colnames(mutepp) == 'Target'] <- 'head'

# replace the string with a numeric id and and convert to numeric
mutepp$head <- mutcorr$Id[match(mutepp$head,mutcorr$clearId)]
mutepp$head <- as.numeric(mutepp$head)

# Add a sequential id column to the mutepp dataframe
mutepp$edge.id <- seq.int(nrow(mutepp))

# remove edges with NA values
mutepp <- subset(mutepp, !is.na(onset))

# initialze network
network <- network.initialize(n = 28)

# copy label column to vertices
set.vertex.attribute(network,"vertex.names",as.vector(mutcorr$Label))

# copy colour column to vertices
set.vertex.attribute(network,"vertex.col",as.vector(mutcorr$colour))

# add edges
add.edges.active(network, tail=mutepp$tail, head=mutepp$head, onset=mutepp$onset, terminus=mutepp$terminus, col=mutepp$colour)

# copy colour column to edges
set.edge.attribute(network,"edge.col",as.vector(mutepp$colour))

# copy label column to edges
set.edge.attribute(network,"edge.label",as.vector(mutepp$Label))

# define time intervals for animation
slice.par <- list(start = 1499, end = 1540, interval = 1,
                  aggregate.dur = 0, rule = "any")
# plot timeslice
plot(tEdgeFormation(network))