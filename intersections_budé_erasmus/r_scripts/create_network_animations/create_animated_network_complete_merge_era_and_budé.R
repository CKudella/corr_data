require(tidyverse)
require(ndtv)
require(htmlwidgets)

# set working directory
getwd()
setwd("../query_results/")

# read data for all correspondents
allcorr <- read.csv("merge_scripts/complete_merge/complete_merge_budé_and_era_correspondents.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# read data for all letters
allepp <- read.csv("merge_scripts/complete_merge/complete_merge_budé_and_era_letters_corr_as_nodes.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# read data for mutual correspondents
mutcorr <- read.csv("intersection_overview/id_and_names_of_mut_corr_era_budé.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

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

# assign specific colour for Budé
allcorr$colour <- ifelse(allcorr$Id == "c0b89c75-45b8-4b04-bfd7-25bfe9ed040b", as.character("#D5AB5B"), allcorr$colour)

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

# conduct edge bundling
allepp <- allepp %>%   group_by(tail, head, onset, terminus, colour) %>%  summarize(weight = n())

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

# copy weight column to edges
set.edge.attribute(network, "edge.weight", as.vector(allepp$weight))

# Combine unique sender and receiver nodes
unique_nodes <- unique(union(allepp$tail, allepp$head))

# initialize an empty data frame to store onset and terminus information
node_info <- data.frame(node_id = character(),
                        onset = as.Date(character()),
                        terminus = as.Date(character()),
                        stringsAsFactors = FALSE)

# iterate through unique nodes
for (node_id in unique_nodes) {
  # select edges where the node is either the sender or receiver
  node_edges <- allepp[allepp$tail == node_id | allepp$head == node_id, ]
  
  # determine the overall onset and terminus based on the aggregated time ranges of connected edges
  onset <- min(node_edges$onset, na.rm = TRUE)
  terminus <- max(node_edges$terminus, na.rm = TRUE)
  
  # append to the node_info data frame
  node_info <- rbind(node_info, data.frame(node_id = node_id, onset = onset, terminus = terminus))
}

# loop for adding onset and terminus to the vertices
for (i in 1:nrow(node_info)) {
  vertex_id <- node_info$node_id[i]
  onset <- min(allepp$onset[allepp$tail == vertex_id | allepp$head == vertex_id], na.rm = TRUE)
  terminus <- max(allepp$terminus[allepp$tail == vertex_id | allepp$head == vertex_id], na.rm = TRUE) + 1
  
  # check if onset and terminus are not NA before activating vertices
  if (!is.na(onset) && !is.na(terminus)) {
    # activate vertices using the determined onset and terminus
    activate.vertices(network, onset = onset, terminus = terminus, v = vertex_id)
  }
}

# find nodes to remove
nodes_to_remove <- setdiff(allcorr$Id, unique_nodes)

# remove nodes without onset and terminus from the network
network <- delete.vertices(network, nodes_to_remove)

# define time intervals for animation
slice.par <- list(start = min(allepp$onset), end = max(allepp$terminus), interval = 1, aggregate.dur = 0, rule = "any")

# compute animation
compute.animation(network, slice.par = slice.par, animation.mode = "kamadakawai")

# set working directory
getwd()
setwd("../network_data/complete_merge_animation/")

# render d3movie and export to a HTML file
render.d3movie(network, slice.par = slice.par, displaylabels = FALSE, animation.mode = "kamadakawai", bg = "#f7f7f7", vertex.col = "vertex.col", vertex.lwd = 2, edge.col = "edge.col", edge.lwd = 2 + get.edge.attribute(network, "edge.weight"), output.mode = "HTML", script.type = "embedded", filename = "animated_network_complete_era_budé.html")

# render animation and export to an animated GIF file
saveGIF(render.animation(network, slice.par = slice.par, displaylabels = FALSE, animation.mode = "kamadakawai", bg = "#f7f7f7", vertex.col = "vertex.col", vertex.lwd = 2, edge.col = "edge.col", edge.lwd = 2 + get.edge.attribute(network, "edge.weight")), movie.name = "animated_network_complete_era_budé.gif", ani.width = 1280, ani.height = 720)
