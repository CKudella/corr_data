require(tidyverse)
require(igraph)
require(rgexf)

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

# cut uncessary label parts from Label column
allcorr$Label <- gsub("\\b(\\W+COE+.*)", "", allcorr$Label)
allcorr$Label <- gsub("^(\\W+E)", "E", allcorr$Label)
allcorr$Label <- gsub("^\\[", "", allcorr$Label)

# modify the label for Erasmus
erasmus_index <- which(allcorr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf")
allcorr$Label[erasmus_index] <- "Desiderius ERASMUS"

# add colour for all correspondents
allcorr$colour <- "#525252"

# add colour column for mutual correspondents to be used with the "give colour to nodes" plugin for gephi
allcorr$colour <- ifelse(allcorr$Id %in% mutcorr$correspondents_id, as.character("#C3161F"), allcorr$colour)

# assign specific colour for erasmus
allcorr$colour <- ifelse(allcorr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf", as.character("#3C93AF"), allcorr$colour)

# assign specific colour for pirckheimer
allcorr$colour <- ifelse(allcorr$Id == "d9233b24-a98c-4279-8065-e2ab70c0d080", as.character("#D5AB5B"), allcorr$colour)

# extract years from send_date_computable1 and generate an ordered list of unique years
allepp$send_date_computable1 <- as.Date(allepp$send_date_computable1)
years_list <- unique(substr(allepp$send_date_computable1, 1, 4))
sorted_years_list <- sort(years_list)
remove(years_list)

# iterate over each year in sorted_years_list
for (year in sorted_years_list) {
  # create a subset dataframe (links) for the current year
  links <- allepp[substr(allepp$send_date_computable1, 1, 4) == as.character(year), c("Source", "Target")]

  # create a subset of allcorr for correspondents (nodes) in links
  relevant_corr_ids <- unique(c(links$Source, links$Target))
  nodes <- allcorr[allcorr$Id %in% relevant_corr_ids, ]

  # assign edge weight
  links$weight <- 1

  # create igraph object
  net <- graph_from_data_frame(d = links, vertices = nodes, directed = TRUE)

  # conduct edge bundling (sum edge weights)
  net2 <- igraph::simplify(net, remove.multiple = TRUE, edge.attr.comb = list(weight = "sum", "ignore"))

  # calculate degree for all nodes
  degAll <- degree(net2, v = V(net2), mode = "all")

  # calculate weighted degree for all nodes
  weightDegAll <- strength(net2, vids = V(net2), mode = "all", loops = TRUE)

  # add new node and edge attributes based on the calculated properties, add colour
  net2 <- set.vertex.attribute(net2, "weightDegAll", index = V(net2), value = weightDegAll)
  net2 <- set.vertex.attribute(net2, "degree", index = V(net2), value = degAll)
  net2 <- set.vertex.attribute(net2, "colour", index = V(net2), value = nodes$colour)
  net2 <- set.edge.attribute(net2, "weight", index = E(net2), value = E(net2)$weight)

  # assign edge colour according to source node
  edge.start <- ends(net2, es = E(net2), names = F)[, 1]
  edge.col <- V(net2)$colour[edge.start]

  # calculate node coordinates
  nodes_coord <- as.data.frame(layout.fruchterman.reingold(net2, weights = E(net2)$weight) * 50)
  nodes_coord <- cbind(nodes_coord, rep(0, times = nrow(nodes_coord)))

  # assign a colour for each node
  nodes_col <- V(net2)$colour
  # transform nodes into a data frame
  nodes_col_df <- as.data.frame(t(col2rgb(nodes_col, alpha = FALSE)))
  nodes_col_df <- cbind(nodes_col_df, alpha = rep(1, times = nrow(nodes_col_df)))
  # assign visual attributes to nodes (RGBA)
  nodes_att_viz <- list(color = nodes_col_df, position = nodes_coord)

  # assign a colour for each edge
  edges_col <- edge.col
  # transform edges into a data frame
  edges_col_df <- as.data.frame(t(col2rgb(edges_col, alpha = FALSE)))
  edges_col_df <- cbind(edges_col_df, alpha = rep(1, times = nrow(edges_col_df)))
  # assign visual attributes to edges (RGBA)
  edges_att_viz <- list(color = edges_col_df)

  # create data frames for gexf export
  nodes_df <- data.frame(ID = c(1:vcount(net2)), NAME = V(net2)$Label)
  edges_df <- as.data.frame(get.edges(net2, c(1:ecount(net2))))

  # create a dataframe with node attributes
  nodes_att <- data.frame(Degree = V(net2)$degree, colour = as.character(nodes$colour), "Weighted Degree" = V(net2)$weightDegAll)

  # define the gexf file name and path
  gexf_file <- file.path("..", "network_data", "complete_merge_time_slices_gexf_created_by_r", sprintf("time_slice_%s_complete_merge_pirck_and_era.gexf", year))

  # create the description with the year for the gexf metadata
  description <- sprintf("A graph representing Erasmus's and Pirckheimer's networks of correspondence in the year %s", year)

  # write gexf
  write.gexf(nodes = nodes_df, edges = edges_df, edgesWeight = E(net2)$weight, nodesAtt = nodes_att, nodesVizAtt = nodes_att_viz, edgesVizAtt = edges_att_viz, defaultedgetype = "directed", meta = list(creator = "Christoph Kudella", description = description), output = gexf_file)
}