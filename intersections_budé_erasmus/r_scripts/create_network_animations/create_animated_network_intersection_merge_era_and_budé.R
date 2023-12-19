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

# set send_date_computable1 as Date
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

# conduct edge bundling
mutepp <- mutepp %>%   group_by(tail, head, onset, terminus, colour) %>%  summarize(weight = n()) 

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

# copy weight column to edges
set.edge.attribute(network, "edge.weight", as.vector(mutepp$weight))

# Combine unique sender and receiver nodes
unique_nodes <- unique(union(mutepp$tail, mutepp$head))

# initialize an empty data frame to store onset and terminus information
node_info <- data.frame(node_id = character(),
                        onset = as.Date(character()),
                        terminus = as.Date(character()),
                        stringsAsFactors = FALSE)

# iterate through unique nodes
for (node_id in unique_nodes) {
  # select edges where the node is either the sender or receiver
  node_edges <- mutepp[mutepp$tail == node_id | mutepp$head == node_id, ]
  
  # determine the overall onset and terminus based on the aggregated time ranges of connected edges
  onset <- min(node_edges$onset, na.rm = TRUE)
  terminus <- max(node_edges$terminus, na.rm = TRUE)
  
  # append to the node_info data frame
  node_info <- rbind(node_info, data.frame(node_id = node_id, onset = onset, terminus = terminus))
}

# loop for adding onset and terminus to the vertices
for (i in 1:nrow(node_info)) {
  vertex_id <- node_info$node_id[i]
  onset <- min(mutepp$onset[mutepp$tail == vertex_id | mutepp$head == vertex_id], na.rm = TRUE)
  terminus <- max(mutepp$terminus[mutepp$tail == vertex_id | mutepp$head == vertex_id], na.rm = TRUE) + 1
  
  # check if onset and terminus are not NA before activating vertices
  if (!is.na(onset) && !is.na(terminus)) {
    # activate vertices using the determined onset and terminus
    activate.vertices(network, onset = onset, terminus = terminus, v = vertex_id)
  }
}

# define time intervals for animation
slice.par <- list(start = min(mutepp$onset), end = max(mutepp$terminus), interval = 1, aggregate.dur = 0, rule = "any")

# compute animation
compute.animation(network, slice.par = slice.par, animation.mode = "kamadakawai")

# set working directory
getwd()
setwd("../network_data/intersection_merge_animation/")

# render d3movie and export to a HTML file
render.d3movie(network, slice.par = slice.par, displaylabels = TRUE, animation.mode = "kamadakawai", bg = "#f7f7f7", vertex.col = "vertex.col", vertex.lwd = 2, edge.col = "edge.col", edge.lwd = 2 + get.edge.attribute(network, "edge.weight"), output.mode = "HTML", script.type = "embedded", filename = "animated_network_intersection_era_budé.html")

# render animation and export to an animated GIF file
saveGIF(render.animation(network, slice.par = slice.par, displaylabels = TRUE, animation.mode = "kamadakawai", bg = "#f7f7f7", vertex.col = "vertex.col", vertex.lwd = 2, edge.col = "edge.col", edge.lwd = 2 + get.edge.attribute(network, "edge.weight")), movie.name = "animated_network_intersection_era_budé.gif", ani.width = 1920, ani.height = 1080)
