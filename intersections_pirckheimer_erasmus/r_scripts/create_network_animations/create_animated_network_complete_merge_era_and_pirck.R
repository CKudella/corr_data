require(tidyverse)
require(ndtv)
require(htmlwidgets)

# set working directory
getwd()
setwd("../query_results/")

# read data for all correspondents
allcorr <- read.csv("merge_scripts/complete_merge/complete_merge_pirck_and_era_correspondents.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# read data for all letters
allepp <- read.csv("merge_scripts/complete_merge/complete_merge_pirck_and_era_letters.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# read data for mutual correspondents
mutcorr <- read.csv("intersection_overview/id_and_names_of_mut_corr_era_pirck.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# remove rows with NA values in send_date_computable1
allepp <- allepp[!is.na(allepp$send_date_computable1), ]

# cut unnecessary label parts from Label column
allcorr$Label <- gsub("\\b(\\W+COE+.*)", "", allcorr$Label)
allcorr$Label <- gsub("^(\\W+E)", "E", allcorr$Label)
allcorr$Label <- gsub("^\\[", "", allcorr$Label)

# modify the label for Erasmus
erasmus_index <- which(allcorr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf")
allcorr$Label[erasmus_index] <- "Desiderius ERASMUS"

# add colour for all correspondents
allcorr$colour <- "#525252"

# add colour column for mutual correspondents to be used with the "give colour to nodes" plugin for Gephi
allcorr$colour <- ifelse(allcorr$Id %in% mutcorr$correspondents_id, as.character("#C3161F"), allcorr$colour)

# assign specific colour for Erasmus
allcorr$colour <- ifelse(allcorr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf", as.character("#3C93AF"), allcorr$colour)

# assign specific colour for Pirckheimer
allcorr$colour <- ifelse(allcorr$Id == "d9233b24-a98c-4279-8065-e2ab70c0d080", as.character("#D5AB5B"), allcorr$colour)

# assign colours to edges according to the source
allepp$colour <- allcorr$colour[match(allepp$Source, allcorr$Id)]

# set send_date_computable1 asDate
allepp$send_date_computable1 <- as.Date(allepp$send_date_computable1, format = "%Y-%m-%d")

# extract start year as onset
allepp$onset <- year(allepp$send_date_computable1)

# extract end year as terminus
allepp$terminus <- year(allepp$send_date_computable1)

# replace the string with a numeric id and convert to numeric
allcorr$clearId <- allcorr$Id
allcorr$Id <- as.integer(rownames(allcorr))
rownames(allcorr) <- NULL

# rename source column as tail
colnames(allepp)[colnames(allepp) == "Source"] <- "tail"

# replace the string with a numeric id and convert to numeric
allepp$tail <- allcorr$Id[match(allepp$tail, allcorr$clearId)]
allepp$tail <- as.numeric(allepp$tail)

# rename target column as head
colnames(allepp)[colnames(allepp) == "Target"] <- "head"

# replace the string with a numeric id and and convert to numeric
allepp$head <- allcorr$Id[match(allepp$head, allcorr$clearId)]
allepp$head <- as.numeric(allepp$head)

# add a sequential id column to the allepp dataframe
allepp$edge.id <- seq.int(nrow(allepp))

# remove edges with NA values
allepp <- subset(allepp, !is.na(onset))

# initialize network
network <- network.initialize(n = nrow(allcorr))

# copy label column to vertices
set.vertex.attribute(network, "vertex.names", as.vector(allcorr$Label))

# copy colour column to vertices
set.vertex.attribute(network, "vertex.col", as.vector(allcorr$colour))

# add edges
add.edges.active(network, tail = allepp$tail, head = allepp$head, onset = allepp$onset, terminus = allepp$terminus, col = allepp$colour)

# copy colour column to edges
set.edge.attribute(network, "edge.col", as.vector(allepp$colour))

# copy label column to edges
set.edge.attribute(network, "edge.label", as.vector(allepp$Label))

# define time intervals for animation
slice.par <- list(start = min(allepp$onset), end = max(allepp$terminus), interval = 1, aggregate.dur = 0, rule = "any")

# compute animation
compute.animation(network, slice.par = slice.par, animation.mode = "kamadakawai")

# set working directory
getwd()
setwd("../network_data/complete_merge_animation/")

# render d3movie and export to a HTML file
render.d3movie(network, slice.par = slice.par, displaylabels = FALSE, animation.mode = "kamadakawai", bg = "#f7f7f7", vertex.col = "vertex.col", vertex.lwd = 2, edge.col = "edge.col", edge.lwd = 5, output.mode = "HTML", script.type = "embedded", filename = "animated_network_complete_era_pirck.html")

# render animation and export to an animated GIF file
saveGIF(render.animation(network, slice.par = slice.par, displaylabels = FALSE, animation.mode = "kamadakawai", bg = "#f7f7f7", vertex.col = "vertex.col", vertex.lwd = 2, edge.col = "edge.col", edge.lwd = 5), movie.name = "animated_network_complete_era_pirck.gif", ani.width = 1280, ani.height = 720)
