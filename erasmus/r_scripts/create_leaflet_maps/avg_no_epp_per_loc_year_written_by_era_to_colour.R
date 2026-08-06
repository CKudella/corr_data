library(tidyverse)
source("leaflet_helpers.R")

# settings

subject_name <- "Erasmus"

data_path   <- "../query_results/no_epp_per_loc/avg_no_epp_per_loc_year_written_by_era_to.csv"
output_path <- "../leaflet_maps/avg_no_epp_per_loc_year_written_by_era_to_colour.html"

measure_col  <- str_glue("Average Number of Letters written by {subject_name} to this location per year")
location_col <- "Location Name"

breaks_method <- "boxplot"
n_classes     <- 4
unit_singular <- "letter"
unit_plural   <- "letters"

description <- str_glue("Average number of letters sent by {subject_name} to this location per year")
map_title   <- description

mapbox_token   <- "pk.eyJ1IjoiY2t1ZGVsbGEiLCJhIjoiY2locnN5ejZuMDAxandza3M4cGtzeXlqYSJ9.olxAQeWGTw_6slIVh4i6Cg"
mapbox_tile_id <- "ckudella/clq3qbtz2004101peb0psb016"

# data preparation

data <- read_csv(data_path, na = c("NULL", ""), show_col_types = FALSE) |>
  rename(n_value = all_of(measure_col), location = all_of(location_col))

breaks <- compute_breaks(data$n_value, method = breaks_method, n_classes = n_classes)
data <- data |> mutate(class = assign_class(n_value, breaks))

bounds <- compute_bounds(data$Latitude, data$Longitude)

# statistics

cat(str_glue("locations: {nrow(data)}"), "\n")
cat(str_glue("breaks: {paste(round(breaks, 1), collapse = ', ')}"), "\n")

# map

m <- leaflet(data) |>
  add_base_tiles(mapbox_id = mapbox_tile_id, mapbox_token = mapbox_token) |>
  addCircleMarkers(
    lng = ~Longitude, lat = ~Latitude,
    popup = build_popup(data$location, description, round(data$n_value, 1)),
    label = ~location, group = "Locations",
    radius = data$class * 3, fillColor = "#C3161F", fillOpacity = 0.7,
    weight = 1, color = "#000000", stroke = TRUE
  ) |>
  fitBounds(bounds$min_lng, bounds$min_lat, bounds$max_lng, bounds$max_lat) |>
  add_map_controls(search_group = "Locations") |>
  addControl(build_legend_html(breaks, unit_singular, unit_plural), position = "bottomright") |>
  addControl(build_title_html(map_title), position = "topright")

m

# save

save_map(m, output_path)