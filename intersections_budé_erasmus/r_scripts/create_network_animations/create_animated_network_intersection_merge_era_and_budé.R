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
mutepp <- mutepp %>%
  group_by(tail, head, onset, terminus, colour) %>%
  summarize(weight = n())

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

# calculate for each node per year (if active) the weighted degree
node_year_wd <- bind_rows(
  mutepp %>% transmute(node_id = tail, active_year = onset, weight),
  mutepp %>% transmute(node_id = head, active_year = onset, weight)
) %>%
  group_by(node_id, active_year) %>%
  summarise(weighted_degree = sum(weight), .groups = "drop") %>%
  arrange(node_id, active_year)

# min-max normalize across all weighted-degree values
wd_all <- node_year_wd$weighted_degree
wd_min <- min(wd_all)
wd_max <- max(wd_all)

min_size <- 0.5
max_size <- 3

node_year_wd <- node_year_wd %>%
  mutate(
    wd_norm = if (wd_max == wd_min) 0.5 else (weighted_degree - wd_min) / (wd_max - wd_min),
    vertex_cex = min_size + (wd_norm^0.25) * (max_size - min_size)
  )

# static fallback size
set.vertex.attribute(network, "vertex.cex", rep(min_size, nrow(mutcorr)))

# activate one vertex.cex value per node per active year
for (i in seq_len(nrow(node_year_wd))) {
  activate.vertex.attribute(
    network,
    prefix = "vertex.cex",
    value = node_year_wd$vertex_cex[i],
    onset = node_year_wd$active_year[i],
    terminus = node_year_wd$active_year[i] + 1,
    v = node_year_wd$node_id[i]
  )
}

# collapse consecutive active years into contiguous spells per node
node_spells <- node_year_wd %>%
  distinct(node_id, active_year) %>%
  group_by(node_id) %>%
  mutate(
    new_spell = active_year - lag(active_year, default = first(active_year)) > 1,
    spell_id = cumsum(new_spell)
  ) %>%
  group_by(node_id, spell_id) %>%
  summarise(onset = min(active_year), terminus = max(active_year) + 1, .groups = "drop") %>%
  select(node_id, onset, terminus)

# unique nodes that have at least one letter
unique_nodes <- unique(node_spells$node_id)

# activate each vertex only for the spell(s) during which it actually was active
for (i in seq_len(nrow(node_spells))) {
  activate.vertices(network, onset = node_spells$onset[i], terminus = node_spells$terminus[i], v = node_spells$node_id[i])
}

# define time intervals for animation
slice.par <- list(start = min(mutepp$onset), end = max(mutepp$terminus), interval = 1, aggregate.dur = 0, rule = "any")

# compute animation
compute.animation(network, slice.par = slice.par, animation.mode = "kamadakawai")

# set working directory
getwd()
setwd("../network_data/intersection_merge_animation/")

# render d3movie and export to a HTML file
render.d3movie(network, slice.par = slice.par, displaylabels = TRUE, animation.mode = "kamadakawai", bg = "#f7f7f7", vertex.col = "vertex.col", vertex.cex = "vertex.cex", vertex.lwd = 2, edge.col = "edge.col", edge.lwd = 2 + get.edge.attribute(network, "edge.weight"), output.mode = "HTML", script.type = "embedded", filename = "animated_network_intersection_era_budé.html")

# render animation and export to an animated GIF file
saveGIF(render.animation(network, slice.par = slice.par, displaylabels = TRUE, animation.mode = "kamadakawai", bg = "#f7f7f7", vertex.col = "vertex.col", vertex.cex = "vertex.cex", vertex.lwd = 2, edge.col = "edge.col", edge.lwd = 2 + get.edge.attribute(network, "edge.weight")), movie.name = "animated_network_intersection_era_budé.gif", ani.width = 1920, ani.height = 1080)
