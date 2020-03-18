require(readr)
require(plyr)
require(igraph)
require(rgexf)
library(readr)
library(plyr)
library(igraph)
library(rgexf)

# set working directory
getwd()
setwd("../query_results/merge_scripts/intersection_merge/")

# read node and edges into dataframe with the name expected by igraph
nodes <- read.csv("time_slice_1514_intersection_merge_pirck_and_era_correspondents.csv", fileEncoding="UTF-8")
links <- read.csv("time_slice_1514_intersection_merge_pirck_and_era_letters_corr_as_nodes.csv", fileEncoding="UTF-8")[ ,c('Source', 'Target')]

setwd("../../")
getwd()
mutcorr <- read.csv("./intersection_overview/id_and_names_of_mut_corr_era_pirck.csv", fileEncoding="UTF-8")

# add colour for all correspondents
nodes$colour <- "#525252"

# add colour column for mutual correspondents t
nodes$colour <- ifelse(nodes$Id %in% mutcorr$correspondents_id, as.character("#C3161F"), nodes$colour)

#assign specific colour for erasmus
nodes$colour <- ifelse(nodes$Id == "erasmus_desiderius_viaf_95982394", as.character("#3C93AF"), nodes$colour)

#assign specific colour for pirckheimer
nodes$colour <- ifelse(nodes$Id == "pirckheimer_willibald_viaf_27173507", as.character("#D5AB5B"), nodes$colour)

#assign edge weight
links$weight <- 1

# create igraph object
net <- graph_from_data_frame(d=links, vertices=nodes, directed=T)

# conduct edge bundling (sum edge weights)
net2 <- igraph::simplify(net, remove.multiple = TRUE, edge.attr.comb=list(weight="sum","ignore"))

# calculate degree for all nodes
degAll <- degree(net2, v = V(net2), mode = "all")

# calculate weighted degree for all nodes
weightDegAll <- strength(net2, vids = V(net2), mode = "all",
                         loops = TRUE)

# add new node and edge attributes based on the calculated properties, add
net2 <- set.vertex.attribute(net2, "weightDegAll", index = V(net2), value = weightDegAll)
net2 <- set.vertex.attribute(net2, "degree", index = V(net2), value = degAll)
net2 <- set.vertex.attribute(net2, "colour", index = V(net2), value = nodes$colour)
net2 <- set.edge.attribute(net2, "weight", index = E(net2), value = E(net2)$weight)

#assign edge colour according to source node
edge.start <- ends(net2, es=E(net2), names=F)[,1]
edge.col <- V(net2)$colour[edge.start]

# layout with FR
l <- layout_with_fr(net2, weights=E(net2)$weight)*3.5

# plot graph
plot(net2, layout=l*5, vertex.color=nodes$colour, vertex.size=2, vertex.label=V(net2)$Label, vertex.label.font=2, vertex.label.color="gray40",
     vertex.label.cex=.3, edge.arrow.size=.2, edge.width=E(net2)$weight*0.5, edge.color=edge.col, vertex.label.family="sans")

#################

# calculate node coordinates
nodes_coord <- as.data.frame(layout.fruchterman.reingold(net2, weights=E(net2)$weight)*50)
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
# Transform it into a data frame (we have to transpose it first)
edges_col_df <- as.data.frame(t(col2rgb(edges_col, alpha = FALSE)))
edges_col_df <- cbind(edges_col_df, alpha = rep(1, times = nrow(edges_col_df)))
# assign visual attributes to edges (RGBA)
edges_att_viz <- list(color = edges_col_df)

# create data frames for gexf export
nodes_df <- data.frame(ID = c(1:vcount(net2)), NAME = V(net2)$Label)
edges_df <- as.data.frame(get.edges(net2, c(1:ecount(net2))))

#create a dataframe with node attributes
nodes_att <- data.frame(Degree = V(net2)$degree, colour = as.character(nodes$colour), "Weighted Degree" = V(net2)$weightDegAll)

setwd("../")
getwd()
setwd("./network_data/complete_merge_time_slices_gexf_created_by_r")

# write gexf
era_pirck_imerge_1514 <- write.gexf(nodes = nodes_df, edges = edges_df, edgesWeight = E(net2)$weight, nodesAtt = nodes_att, nodesVizAtt = nodes_att_viz, edgesVizAtt = edges_att_viz, defaultedgetype = "directed",  meta = list( creator="Christoph Kudella",  description="A graph representing the intersection between Erasmus's and Pirckheimer's networks of correspondence in the year 1514"), output="era_pirck_imerge_1514.gexf")
