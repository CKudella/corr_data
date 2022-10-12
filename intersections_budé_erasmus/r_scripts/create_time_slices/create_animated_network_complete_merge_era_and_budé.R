require(readr)
require(lubridate)
require(ndtv)

# set working directory
getwd()
setwd("../query_results/")

# read data for correspondents
corr<-read.csv("merge_scripts/complete_merge/complete_merge_budé_and_era_correspondents.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# read data for letters exchanged between erasmus, budé, and all their correspondents
epp<-read.csv("merge_scripts/complete_merge/complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8", na.strings=c("NULL"))

# cut uncessary label parts from Label column
corr$Label <- gsub("\\b(\\W+COE+.*)", "", corr$Label)
corr$Label <- gsub("^(\\W+E)", "E", corr$Label)

# add colour column for mutual correspondents to be used with the "give colour to nodes" plugin for gephi
corr$colour <- "#c3161F"

#assign specific colour for erasmus
corr$colour <- ifelse(corr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf", as.character("#3c93AF"), corr$colour)

#assign specific colour for budé
corr$colour <- ifelse(corr$Id == "c0b89c75-45b8-4b04-bfd7-25bfe9ed040b", as.character("#D5ab5b"), corr$colour)

# assign colours to edges according to the source
epp$colour <- corr$colour[match(epp$Source,corr$Id)]

# set send_date_computable1 asDate
epp$send_date_computable1 <- as.Date(epp$send_date_computable1, format="%Y-%m-%d")

# extract start year as onset
epp$onset <- year(epp$send_date_computable1)

# set send_date_computable2 asDate
epp$send_date_computable2 <- as.Date(epp$send_date_computable2, format="%Y-%m-%d")

# extract end year as terminus
epp$terminus <- year(epp$send_date_computable2)

# replace the string with a numeric id and convert to numeric
corr$clearId <- corr$Id
corr$Id <- as.factor(corr$Id)
levels(corr$Id) <- 1:length(levels(corr$Id))
corr$Id <- as.numeric(corr$Id)

# rename source column as tail
colnames(epp)[colnames(epp) == 'Source'] <- 'tail'

# replace the string with a numeric id and convert to numeric
epp$tail <- corr$Id[match(epp$tail,corr$clearId)]
epp$tail <- as.numeric(epp$tail)

# rename target column as head
colnames(epp)[colnames(epp) == 'Target'] <- 'head'

# replace the string with a numeric id and and convert to numeric
epp$head <- corr$Id[match(epp$head,corr$clearId)]
epp$head <- as.numeric(epp$head)

# Add a sequential id column to the epp dataframe
epp$edge.id <- seq.int(nrow(epp))

# remove edges with NA values
epp <- subset(epp, !is.na(onset))

# initialze network
network <- network.initialize(n = nrow(corr))

# copy label column to vertices
set.vertex.attribute(network,"vertex.names",as.vector(corr$Label))

# copy colour column to vertices
set.vertex.attribute(network,"vertex.col",as.vector(corr$colour))

# add edges
add.edges.active(network, tail=epp$tail, head=epp$head, onset=epp$onset, terminus=epp$terminus, col=epp$colour)

# copy colour column to edges
set.edge.attribute(network,"edge.col",as.vector(epp$colour))

# copy label column to edges
set.edge.attribute(network,"edge.label",as.vector(epp$Label))

# define time intervals for animation
slice.par <- list(start = 1499, end = 1540, interval = 1,
                  aggregate.dur = 0, rule = "any")

# render d3movie as htmlwidget
render.d3movie(network, slice.par = slice.par, displaylabels=TRUE, animation.mode='kamadakawai', bg='#f7f7f7', vertex.col = "vertex.col", vertex.lwd=2, edge.col = "edge.col")