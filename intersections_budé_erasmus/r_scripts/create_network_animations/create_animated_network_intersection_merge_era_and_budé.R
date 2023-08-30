require(tidyverse)
require(ndtv)
require(htmlwidgets)

# set working directory
getwd()
setwd("../query_results/")

# read data for mutual correspondents
mutcorr <- read.csv("merge_scripts/intersection_merge/intersection_merge_era_and_budé_correspondents.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# read data for letters exchanged between Erasmus, Budé, and their mutual correspondents
mutepp <- read.csv("merge_scripts/intersection_merge/intersection_merge_era_and_budé_letters_corr_as_nodes.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# cut unnecessary label parts from Label column
mutcorr$Label <- gsub("\\b(\\W+COE+.*)", "", mutcorr$Label)
mutcorr$Label <- gsub("^(\\W+E)", "E", mutcorr$Label)
mutcorr$Label <- gsub("^\\[", "", mutcorr$Label)

# modify the label for Erasmus
erasmus_index <- which(mutcorr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf")
mutcorr$Label[erasmus_index] <- "Desiderius ERASMUS"

# add colour column for mutual correspondents
mutcorr$colour <- "#C3161F"

# assign specific colour for Erasmus
mutcorr$colour <- ifelse(mutcorr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf", as.character("#3C93AF"), mutcorr$colour)

# assign specific colour for Budé
mutcorr$colour <- ifelse(mutcorr$Id == "c0b89c75-45b8-4b04-bfd7-25bfe9ed040b", as.character("#D5AB5B"), mutcorr$colour)

# assign colours to edges according to the source
mutepp$colour <- mutcorr$colour[match(mutepp$Source, mutcorr$Id)]

# set send_date_computable1 asDate
mutepp$send_date_computable1 <- as.Date(mutepp$send_date_computable1, format = "%Y-%m-%d")

# extract start year as onset
mutepp$onset <- year(mutepp$send_date_computable1)

# extract end year as terminus
mutepp$terminus <- year(mutepp$send_date_computable1)

# replace the string with a numeric id and convert to numeric
mutcorr$clearId <- mutcorr$Id
mutcorr$Id <- as.integer(rownames(mutcorr))
rownames(mutcorr) <- NULL

# rename source column as tail
colnames(mutepp)[colnames(mutepp) == "Source"] <- "tail"

# replace the string with a numeric id and convert to numeric
mutepp$tail <- mutcorr$Id[match(mutepp$tail, mutcorr$clearId)]
mutepp$tail <- as.numeric(mutepp$tail)

# rename target column as head
colnames(mutepp)[colnames(mutepp) == "Target"] <- "head"

# replace the string with a numeric id and and convert to numeric
mutepp$head <- mutcorr$Id[match(mutepp$head, mutcorr$clearId)]
mutepp$head <- as.numeric(mutepp$head)

# add a sequential id column to the mutepp dataframe
mutepp$edge.id <- seq.int(nrow(mutepp))

# remove edges with NA values
mutepp <- subset(mutepp, !is.na(onset))

# initialize network
network <- network.initialize(n = nrow(mutcorr))

# copy label column to vertices
set.vertex.attribute(network, "vertex.names", as.vector(mutcorr$Label))

# copy colour column to vertices
set.vertex.attribute(network, "vertex.col", as.vector(mutcorr$colour))

# add edges
add.edges.active(network, tail = mutepp$tail, head = mutepp$head, onset = mutepp$onset, terminus = mutepp$terminus, col = mutepp$colour)

# copy colour column to edges
set.edge.attribute(network, "edge.col", as.vector(mutepp$colour))

# copy label column to edges
set.edge.attribute(network, "edge.label", as.vector(mutepp$Label))

# define time intervals for animation
slice.par <- list(start = min(mutepp$onset), end = max(mutepp$terminus), interval = 1, aggregate.dur = 0, rule = "any")

# compute animation
compute.animation(network, slice.par = slice.par, animation.mode = "kamadakawai")

# set working directory
getwd()
setwd("../network_data/intersection_merge_animation/")

# render d3movie and export to a HTML file
render.d3movie(network, slice.par = slice.par, displaylabels = TRUE, animation.mode = "kamadakawai", bg = "#f7f7f7", vertex.col = "vertex.col", vertex.lwd = 2, edge.col = "edge.col", edge.lwd = 5, output.mode = "HTML", script.type = "embedded", filename = "animated_network_intersection_era_budé.html")

# render animation and export to an animated GIF file
saveGIF(render.animation(network, slice.par = slice.par, displaylabels = TRUE, animation.mode = "kamadakawai", bg = "#f7f7f7", vertex.col = "vertex.col", vertex.lwd = 2, edge.col = "edge.col", edge.lwd = 5), movie.name = "animated_network_intersection_era_budé.gif", ani.width = 1920, ani.height = 1080)
