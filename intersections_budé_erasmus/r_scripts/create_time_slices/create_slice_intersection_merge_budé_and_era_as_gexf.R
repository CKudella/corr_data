require(tidyverse)
require(igraph)
require(rgexf)

# set working directory
getwd()
setwd("../query_results/")

# read data for mutual correspondents
mutcorr <- read.csv("merge_scripts/intersection_merge/intersection_merge_era_and_budé_correspondents.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# read data for letters exchanged between Erasmus, Budé, and their mutual correspondents
mutepp <- read.csv("merge_scripts/intersection_merge/intersection_merge_era_and_budé_letters_corr_as_nodes.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# remove rows with NA values in send_date_computable1
mutepp <- mutepp[!is.na(mutepp$send_date_computable1), ]

# cut unnecessary label parts from Label column
mutcorr$Label <- gsub("\\b(\\W+COE+.*)", "", mutcorr$Label)
mutcorr$Label <- gsub("^(\\W+E)", "E", mutcorr$Label)
mutcorr$Label <- gsub("^\\[", "", mutcorr$Label)
mutcorr$Label <- stringr::str_replace_all(mutcorr$Label, "\\b\\p{Lu}{2,}\\b", function(m) {
  ifelse(stringr::str_detect(m, "^[IVXLCDM]+$"), m, stringr::str_to_title(m))
})

# override the programmatically derived labels
erasmus_index <- which(mutcorr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf")
mutcorr$Label[erasmus_index] <- "Desiderius Erasmus"
unnamed_person_index <- which(mutcorr$Id == "be1dcbc4-3987-472a-b4a0-c3305ead139f")
mutcorr$Label[unnamed_person_index] <- "[?]"
martinus_of_ep_76_person_index <- which(mutcorr$Id == "ecbf6eb8-e2e8-48f8-a46a-2e34c0cd604c")
mutcorr$Label[martinus_of_ep_76_person_index] <- "Martinus [of Ep 76]"
ludovicus_bruges_index <- which(mutcorr$Id == "fb407a51-6dfa-48d4-9eb1-5c6b8ed756a5")
mutcorr$Label[ludovicus_bruges_index] <- "Ludovicus [documented at Bruges 1517-18]"
ludovicus_of_ep_167_index <- which(mutcorr$Id == "d26ad69b-74c9-4213-97fe-e4bccc9bbe33")
mutcorr$Label[ludovicus_of_ep_167_index] <- "Ludovicus [of Ep 167]"
cornelis_of_bergen_of_ep_1562_index <- which(mutcorr$Id == "de457db2-5ab6-4928-ad83-954d7c89876a")
mutcorr$Label[cornelis_of_bergen_of_ep_1562_index] <- "Cornelis of Bergen [of Ep 1562]"

# add colour for all correspondents
mutcorr$colour <- "#C3161F"

# assign specific colour for Erasmus
mutcorr$colour <- ifelse(mutcorr$Id == "17c580aa-3ba7-4851-8f26-9b3a0ebeadbf", as.character("#3C93AF"), mutcorr$colour)

# assign specific colour for Budé
mutcorr$colour <- ifelse(mutcorr$Id == "c0b89c75-45b8-4b04-bfd7-25bfe9ed040b", as.character("#D5AB5B"), mutcorr$colour)

# extract years from send_date_computable1 and generate an ordered list of unique years
mutepp$send_date_computable1 <- as.Date(mutepp$send_date_computable1)
years_list <- unique(substr(mutepp$send_date_computable1, 1, 4))
sorted_years_list <- sort(years_list)
remove(years_list)

# iterate over each year in sorted_years_list
for (year in sorted_years_list) {
  # create a subset dataframe (links) for the current year
  links <- mutepp[substr(mutepp$send_date_computable1, 1, 4) == as.character(year), c("Source", "Target")]

  # create a subset of mutcorr for correspondents (nodes) in links
  relevant_corr_ids <- unique(c(links$Source, links$Target))
  nodes <- mutcorr[mutcorr$Id %in% relevant_corr_ids, ]

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
  nodes_df <- data.frame(ID = c(1:vcount(net2)), NAME = V(net2)$Label)
  edges_df <- as.data.frame(get.edges(net2, c(1:ecount(net2))))

  # create a dataframe with node attributes
  nodes_att <- data.frame(Degree = V(net2)$degree, colour = as.character(nodes$colour), "Weighted Degree" = V(net2)$weightDegAll)

  # define the gexf file name and path
  gexf_file <- file.path("..", "network_data", "intersection_merge_time_slices_gexf_created_by_r", sprintf("time_slice_%s_intersection_merge_budé_and_era.gexf", year))

  # create the description with the year for the gexf metadata
  description <- sprintf("A graph representing the intersection between Erasmus's and Budé's networks of correspondence in the year %s", year)

  # write gexf
  write.gexf(nodes = nodes_df, edges = edges_df, edgesWeight = E(net2)$weight, nodesAtt = nodes_att, nodesVizAtt = nodes_att_viz, edgesVizAtt = edges_att_viz, defaultedgetype = "directed", meta = list(creator = "Christoph Kudella", description = description), output = gexf_file)
}