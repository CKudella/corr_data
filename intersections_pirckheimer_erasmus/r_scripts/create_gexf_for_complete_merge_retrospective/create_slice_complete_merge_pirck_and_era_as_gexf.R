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

# cut unnecessary label parts from Label column
allcorr$Label <- gsub("\\b(\\W+COE+.*)", "", allcorr$Label)
allcorr$Label <- gsub("^(\\W+E)", "E", allcorr$Label)
allcorr$Label <- gsub("^\\[", "", allcorr$Label)
allcorr$Label <- stringr::str_replace_all(allcorr$Label, "\\b\\p{Lu}{2,}\\b", function(m) {
  ifelse(stringr::str_detect(m, "^[IVXLCDM]+$"), m, stringr::str_to_title(m))
})

# override the programmatically derived labels
erasmus_index <- which(allcorr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf")
allcorr$Label[erasmus_index] <- "Desiderius Erasmus"
unnamed_person_index <- which(allcorr$Id == "be1dcbc4-3987-472a-b4a0-c3305ead139f")
allcorr$Label[unnamed_person_index] <- "[?]"
martinus_of_ep_76_person_index <- which(allcorr$Id == "ecbf6eb8-e2e8-48f8-a46a-2e34c0cd604c")
allcorr$Label[martinus_of_ep_76_person_index] <- "Martinus [of Ep 76]"
ludovicus_bruges_index <- which(allcorr$Id == "fb407a51-6dfa-48d4-9eb1-5c6b8ed756a5")
allcorr$Label[ludovicus_bruges_index] <- "Ludovicus [documented at Bruges 1517-18]"
ludovicus_of_ep_167_index <- which(allcorr$Id == "d26ad69b-74c9-4213-97fe-e4bccc9bbe33")
allcorr$Label[ludovicus_of_ep_167_index] <- "Ludovicus [of Ep 167]"
cornelis_of_bergen_of_ep_1562_index <- which(allcorr$Id == "de457db2-5ab6-4928-ad83-954d7c89876a")
allcorr$Label[cornelis_of_bergen_of_ep_1562_index] <- "Cornelis of Bergen [of Ep 1562]"
margaretha_rauch_index <- which(allcorr$Id == "3d8ecfd2-0603-4419-9f51-347e05b99d1c")
allcorr$Label[margaretha_rauch_index] <- "Margaretha Rauch"
hans_scharpff_index <- which(allcorr$Id == "4cabf5c0-2b3c-4bb7-9837-8e29e814d814")
allcorr$Label[hans_scharpff_index] <- "Hans Scharpff"
katharina_herden_index <- which(allcorr$Id == "6edb3723-07a3-427b-aadf-910221d1c0b3")
allcorr$Label[katharina_herden_index] <- "Katharina Herden"
georg_schenk_von_limpurg_index <- which(allcorr$Id == "801483b2-c423-4b08-957b-fc245b201c87")
allcorr$Label[georg_schenk_von_limpurg_index] <- "Georg (III), Schenk von Limpurg"
georg_sauermann_index <- which(allcorr$Id == "9f4f356c-c07c-43fc-b13f-0d90fbe23da1")
allcorr$Label[georg_sauermann_index] <- "Georg Sauermann"
katharina_habermayerin_index <- which(allcorr$Id == "cd68e0d6-f6e2-4d89-bea9-7bc9c74d9f87")
allcorr$Label[katharina_habermayerin_index] <- "Katharina Habermayerin"
katharina__von_stetten_index <- which(allcorr$Id == "e089bd69-f9b2-4bd5-b9c4-57b52f3a7145")
allcorr$Label[katharina__von_stetten_index] <- "Katharina von Stetten"
ulrich_varnbüler_index <- which(allcorr$Id == "ed930b47-2327-461d-8784-59d26a9694dd")
allcorr$Label[ulrich_varnbüler_index] <- "Ulrich Varnbüler"

# add colour for all correspondents
allcorr$colour <- "#525252"

# add colour column for mutual correspondents to be used with the "give colour to nodes" plugin for gephi
allcorr$colour <- ifelse(allcorr$Id %in% mutcorr$correspondents_id, as.character("#C3161F"), allcorr$colour)

# assign specific colour for Erasmus
allcorr$colour <- ifelse(allcorr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf", as.character("#3C93AF"), allcorr$colour)

# assign specific colour for Pirckheimer
allcorr$colour <- ifelse(allcorr$Id == "d9233b24-a98c-4279-8065-e2ab70c0d080", as.character("#D5AB5B"), allcorr$colour)

# create a subset dataframe (links) for all years
links <- allepp[c("Source", "Target")]

# assign edge weight
links$weight <- 1

# create igraph object
net <- graph_from_data_frame(d = links, vertices = allcorr, directed = TRUE)

# conduct edge bundling (sum edge weights)
net2 <- igraph::simplify(net, remove.multiple = TRUE, edge.attr.comb = list(weight = "sum", "ignore"))

# calculate degree for all nodes
degAll <- degree(net2, v = V(net2), mode = "all")

# calculate weighted degree for all nodes
weightDegAll <- strength(net2, vids = V(net2), mode = "all", loops = TRUE)

# add new node and edge attributes based on the calculated properties, add colour
net2 <- set.vertex.attribute(net2, "weightDegAll", index = V(net2), value = weightDegAll)
net2 <- set.vertex.attribute(net2, "degree", index = V(net2), value = degAll)
net2 <- set.vertex.attribute(net2, "colour", index = V(net2), value = allcorr$colour)
net2 <- set.edge.attribute(net2, "weight", index = E(net2), value = E(net2)$weight)

# assign edge colour according to source node
edge.start <- ends(net2, es = E(net2), names = FALSE)[, 1]
edge.col <- allcorr$colour[edge.start]

# calculate node coordinates
nodes_coord <- as.data.frame(layout.fruchterman.reingold(net2, weights = E(net2)$weight) * 50)
nodes_coord <- cbind(nodes_coord, rep(0, times = nrow(nodes_coord)))

# assign a colour for each node
nodes_col <- allcorr$colour
# transform nodes into a data frame
nodes_col_df <- as.data.frame(t(col2rgb(nodes_col, alpha = FALSE)))
nodes_col_df <- cbind(nodes_col_df, alpha = rep(1, times = nrow(nodes_col_df)))
# scale node sizes by weighted degree using a fourth-root transform, imitating Gephi's third spline template
wd <- V(net2)$weightDegAll
wd_norm <- if (max(wd) == min(wd)) {
  rep(0.5, length(wd)) # edge case: all nodes have identical degree
} else {
  (wd - min(wd)) / (max(wd) - min(wd))
}
node_sizes <- 5 + (wd_norm^0.25) * (50 - 5)
nodes_att_viz <- list(color = nodes_col_df, position = nodes_coord, size = node_sizes)

# assign a colour for each edge
edges_col <- edge.col

# transform edges into a data frame
edges_col_df <- as.data.frame(t(col2rgb(edges_col, alpha = FALSE)))
edges_col_df <- cbind(edges_col_df, alpha = rep(1, times = nrow(edges_col_df)))
# assign visual attributes to edges (RGBA)
edges_att_viz <- list(color = edges_col_df)

# create data frames for gexf export
nodes_df <- data.frame(ID = c(1:vcount(net2)), NAME = allcorr$Label)
edges_df <- as.data.frame(get.edges(net2, c(1:ecount(net2))))

# create a dataframe with node attributes
nodes_att <- data.frame(Degree = V(net2)$degree, colour = as.character(allcorr$colour), "Weighted Degree" = V(net2)$weightDegAll)

# define the gexf file name and path
gexf_file <- file.path("..", "network_data", "complete_merge_retrospective_gexf_created_by_r", "complete_merge_pirck_and_era.gexf")

# create the description for the gexf metadata
description <- "A graph representing the complete merge of Erasmus's and Pirckheimer's networks of correspondence."

# write gexf
write.gexf(nodes = nodes_df, edges = edges_df, edgesWeight = E(net2)$weight, nodesAtt = nodes_att, nodesVizAtt = nodes_att_viz, edgesVizAtt = edges_att_viz, defaultedgetype = "directed", meta = list(creator = "Christoph Kudella", description = description), output = gexf_file)
