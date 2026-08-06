library(tidyverse)
source("leaflet_helpers.R")

# settings

subject_name <- "Erasmus"

nodes_path       <- "../query_results/create_geolayout_files_for_gephi/nodes_egdes_for_epp_sent_to_era/create_nodes_locations_for_epp_sent_to_era.csv"
edges_path       <- "../query_results/create_geolayout_files_for_gephi/nodes_egdes_for_epp_sent_to_era/create_edges_epp_sent_to_era.csv"
breaks_data_path <- "../query_results/no_epp_per_loc/no_epp_per_loc_sent_to_era_with_geocoordinates.csv"
output_path      <- "../leaflet_maps/nodes_edges_for_epp_sent_to_era_colour.html"

measure_col  <- str_glue("Number of letters sent from this location to {subject_name}")
location_col <- "Location Name"

breaks_method <- "boxplot"
n_classes     <- 4
line_widths   <- c(0.6, 2.4, 4.2, 6.0, 7.8)

self_loop_description <- str_glue("Number of letters sent to {subject_name} within this city")
node_description       <- str_glue("Number of letters sent to {subject_name} from this location")
map_title               <- str_glue("Letters sent to {subject_name}: network view")

mapbox_token   <- "pk.eyJ1IjoiY2t1ZGVsbGEiLCJhIjoiY2locnN5ejZuMDAxandza3M4cGtzeXlqYSJ9.olxAQeWGTw_6slIVh4i6Cg"
mapbox_tile_id <- "ckudella/clq3qbtz2004101peb0psb016"

# data preparation

nodes <- read_csv(nodes_path, na = c("NULL", ""), show_col_types = FALSE)
edges <- read_csv(edges_path, na = c("NULL", ""), show_col_types = FALSE)

breaks_data <- read_csv(breaks_data_path, na = c("NULL", ""), show_col_types = FALSE) |>
  rename(location = all_of(location_col), n_value = all_of(measure_col))

nodes <- nodes |>
  left_join(breaks_data |> select(location, n_value), by = c("Label" = "location")) |>
  rename(degree = n_value) |>
  mutate(radius = 3)

edges_with_weights <- edges |>
  count(Source, Target, name = "weight") |>
  mutate(self_loop = Source == Target)

breaks <- compute_breaks(c(breaks_data$n_value, edges_with_weights$weight),
                          method = breaks_method, n_classes = n_classes)

edges_with_weights <- edges_with_weights |>
  mutate(class = assign_class(weight, breaks))

self_loops <- edges_with_weights |>
  filter(self_loop) |>
  rename(Id = Source) |>
  select(Id, weight)

nodes_self_loops <- nodes |> inner_join(self_loops, by = "Id")

regular_edges  <- edges_with_weights |> filter(!self_loop)
edges_by_class <- split(regular_edges, regular_edges$class)

bounds <- compute_bounds(nodes$locations_lat, nodes$locations_lng)

# statistics

cat(str_glue("nodes: {nrow(nodes)}"), "\n")
cat(str_glue("edges (excl. self-loops): {nrow(regular_edges)}"), "\n")
cat(str_glue("self-loops: {nrow(self_loops)}"), "\n")
cat(str_glue("breaks: {paste(round(breaks, 1), collapse = ', ')}"), "\n")

# map

m <- leaflet() |>
  add_base_tiles(mapbox_id = mapbox_tile_id, mapbox_token = mapbox_token)

m <- m |>
  addPulseMarkers(
    data = nodes_self_loops,
    lng = ~locations_lng, lat = ~locations_lat, label = ~Label,
    icon = makePulseIcon(color = "#C3161F", heartbeat = 1, iconSize = c(6, 6)),
    popup = build_popup(nodes_self_loops$Label, self_loop_description, nodes_self_loops$weight),
    group = "Inner-City Letters (Self-Loops)"
  )

for (i in seq_along(edges_by_class)) {
  combined <- edges_by_class[[i]] |>
    left_join(nodes, by = c("Source" = "Id")) |>
    rename(lat_source = locations_lat, lng_source = locations_lng) |>
    left_join(nodes, by = c("Target" = "Id")) |>
    rename(lat_target = locations_lat, lng_target = locations_lng)

  m <- m |>
    addPolylines(
      data = combined,
      lng = as.numeric(unlist(apply(combined, 1, function(row) c(row["lng_source"], row["lng_target"], NA)))),
      lat = as.numeric(unlist(apply(combined, 1, function(row) c(row["lat_source"], row["lat_target"], NA)))),
      color = "#C3161F", weight = line_widths[i], opacity = 0.7,
      group = str_glue("Edges - Class {i}")
    )
}

m <- m |>
  addCircleMarkers(
    data = nodes,
    lng = ~locations_lng, lat = ~locations_lat,
    popup = build_popup(nodes$Label, node_description, nodes$degree),
    group = "Nodes", label = ~Label, radius = 2,
    fillColor = "#C3161F", fillOpacity = 0.7, color = "#000000", weight = 1
  ) |>
  addLayersControl(
    overlayGroups = c("Nodes",
                       str_glue("Edges - Class {seq_along(edges_by_class)}"),
                       "Inner-City Letters (Self-Loops)"),
    options = layersControlOptions(collapsed = FALSE)
  ) |>
  fitBounds(bounds$min_lng, bounds$min_lat, bounds$max_lng, bounds$max_lat) |>
  add_map_controls(search_group = "Nodes") |>
  addControl(build_legend_html(breaks, "letter", "letters", shape = "line"), position = "bottomright") |>
  addControl(build_title_html(map_title), position = "topright")

m

# save

save_map(m, output_path)