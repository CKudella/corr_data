require(tidyverse)
require(leaflet)
require(classInt) # for Jenks algorithm
require(htmlwidgets)
require(leaflet.extras) # Provides addEasyButton()
require(htmltools) # For custom legend

# Set working directory
getwd()
setwd("../query_results/")

# Read data
nodes <- read.csv("create_geolayout_files_for_gephi/nodes_egdes_for_epp_sent_to_pirck/create_nodes_locations_for_epp_sent_to_pirck.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))
edges <- read.csv("create_geolayout_files_for_gephi/nodes_egdes_for_epp_sent_to_pirck/create_edges_epp_sent_to_pirck.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))
data_for_breaks <- read.csv("no_epp_per_loc/no_epp_per_loc_sent_to_pirck_with_geocoordinates.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# Select only the relevant columns from letter_counts
letter_counts <- data_for_breaks %>%
  select(Location.Name, Number.of.Letters.sent.from.this.location.TO.Pirckheimer)

# Merge letter_counts with nodes, adding only the 'degree' column
nodes <- nodes %>%
  left_join(letter_counts, by = c("Label" = "Location.Name")) %>%
  rename(degree = Number.of.Letters.sent.from.this.location.TO.Pirckheimer) # Rename the column to 'degree'

# Create initial map bounds
min_lat <- min(nodes$locations_lat, na.rm = TRUE)
max_lat <- max(nodes$locations_lat, na.rm = TRUE)
min_lng <- min(nodes$locations_lng, na.rm = TRUE)
max_lng <- max(nodes$locations_lng, na.rm = TRUE)

# Mapbox API Key
mapbox_api_key <- "pk.eyJ1IjoiY2t1ZGVsbGEiLCJhIjoiY2locnN5ejZuMDAxandza3M4cGtzeXlqYSJ9.olxAQeWGTw_6slIVh4i6Cg"

# Set a fixed radius for all circle markers (3)
nodes$radius <- 3

# Calculate edge weights by counting occurrences of each unique Source-Target pair
edges_with_weights <- edges %>%
  group_by(Source, Target) %>%
  tally(name = "weight") # Create a new column 'weight' that holds the count of occurrences

# Determine breaks
median_val <- median(data_for_breaks$Number.of.Letters.sent.from.this.location.TO.Pirckheimer, na.rm = TRUE)
q1 <- quantile(data_for_breaks$Number.of.Letters.sent.from.this.location.TO.Pirckheimer, 0.25, na.rm = TRUE)
q3 <- quantile(data_for_breaks$Number.of.Letters.sent.from.this.location.TO.Pirckheimer, 0.75, na.rm = TRUE)
box_stats <- boxplot.stats(data_for_breaks$Number.of.Letters.sent.from.this.location.TO.Pirckheimer)
upper_whisker <- box_stats$stats[5]
outliers <- min(box_stats$out)

# Define breaks including max value to ensure all data points are included
breaks <- c(
  min(data_for_breaks$Number.of.Letters.sent.from.this.location.TO.Pirckheimer, na.rm = TRUE),
  median_val, q3, outliers, max(edges_with_weights$weight, na.rm = TRUE)
)

# Ensure breaks are treated as a numeric vector
breaks_numeric <- as.numeric(breaks)

# Assign classes
edges_with_weights$class <- findInterval(edges_with_weights$weight, breaks, all.inside = TRUE)

# Identify self-loops
edges_with_weights$self_loop <- edges_with_weights$Source == edges_with_weights$Target

# Separate self-loops and regular edges **after** classification
self_loops <- edges_with_weights %>% filter(self_loop)
regular_edges <- edges_with_weights %>% filter(!self_loop)

# Create a vector of line widths for each class
line_widths <- c(0.6, 2.4, 4.2, 6.0, 7.8)

# Split regular edges by class
edges_by_class <- split(regular_edges, regular_edges$class)

# Create the leaflet map
m <- leaflet() %>%
  addProviderTiles(
    provider = "MapBox",
    options = providerTileOptions(
      id = "ckudella/clq3qbtz2004101peb0psb016",
      accessToken = mapbox_api_key
    )
  )

# Extract self-loops
self_loops <- edges_with_weights %>%
  filter(Source == Target) %>%
  rename(Id = Source) %>%
  select(Id, weight) # Keep only the node ID and weight

# Merge self-loops data with nodes to get locations
nodes_self_loops <- nodes %>%
  inner_join(self_loops, by = "Id")

# Add pulse markers for self-loops with correct popup information
m <- m %>%
  addPulseMarkers(
    data = nodes_self_loops,
    lng = ~locations_lng,
    lat = ~locations_lat,
    label = ~Label,
    icon = makePulseIcon(color = "#C3161F", heartbeat = 1, iconSize = c(6, 6)),
    popup = ~ paste0("<b>", Label, "</b><br>Number of letters sent to Pirckheimer within this city: ", weight), # Use weight
    group = "Inner-City Letters (Self-Loops)"
  )

# Add polylines for each class separately
for (i in 1:length(edges_by_class)) {
  # Join edges with node coordinates
  combined_locations <- edges_by_class[[i]] %>%
    left_join(nodes, by = c("Source" = "Id")) %>%
    rename(locations_lat_source = locations_lat, locations_lng_source = locations_lng) %>%
    left_join(nodes, by = c("Target" = "Id")) %>%
    rename(locations_lat_target = locations_lat, locations_lng_target = locations_lng)

  # Add polylines with adjusted coordinate structure
  m <- m %>%
    addPolylines(
      data = combined_locations,
      lng = as.numeric(unlist(apply(combined_locations, 1, function(row) c(row["locations_lng_source"], row["locations_lng_target"], NA)))),
      lat = as.numeric(unlist(apply(combined_locations, 1, function(row) c(row["locations_lat_source"], row["locations_lat_target"], NA)))),
      color = "#C3161F",
      weight = line_widths[i],
      opacity = 0.7,
      group = paste("Edges - Class", i)
    )
}

# Add Circle Markers (Nodes)
m <- m %>%
  addCircleMarkers(
    data = nodes,
    lng = ~locations_lng,
    lat = ~locations_lat,
    popup = paste("<b>", nodes$Label, "</b><br>Number of letters sent to Pirckheimer from this location : ", nodes$degree),
    group = "Nodes",
    label = ~Label,
    radius = 2,
    fillColor = "#C3161F",
    fillOpacity = 0.7,
    color = "#000000",
    weight = 1
  ) %>%
  addLayersControl(
    overlayGroups = c("Nodes", paste("Edges - Class", 1:4), "Inner-City Letters (Self-Loops)"),
    options = layersControlOptions(collapsed = FALSE)
  ) %>%
  fitBounds(min_lng, min_lat, max_lng, max_lat) %>%
  addScaleBar(position = "bottomleft", options = scaleBarOptions(metric = TRUE, imperial = FALSE)) %>%
  addSearchFeatures(
    targetGroups = c("Nodes"),
    options = searchFeaturesOptions(
      zoom = 10,
      openPopup = TRUE,
      position = "topleft"
    )
  ) %>%
  addEasyButton(
    easyButton(
      icon = "fa-globe",
      title = "Reset Zoom",
      onClick = JS("function(btn, map){ map.fitBounds(map.initialBounds); }")
    )
  ) %>%
  onRender(JS("
    function(el, x) {
      var map = this;
      setTimeout(function() {
        if (map.getBounds) {
          map.initialBounds = map.getBounds();
        } else {
          console.error('Error: getBounds() function is not available.');
        }
      }, 1000);
    }
  "))

# Detect if any number has decimal places
if (any(breaks_numeric %% 1 != 0)) {
  format_numbers <- function(x) sprintf("%.2f", x) # Format to 2 decimal places
  adjust_value <- 0.01
} else {
  format_numbers <- function(x) as.character(x) # Keep whole numbers
  adjust_value <- 1
}

# Detect if any number has decimal places
if (any(breaks_numeric %% 1 != 0)) {
  format_numbers <- function(x) sprintf("%.2f", x) # Format to 2 decimal places
  adjust_value <- 0.01
} else {
  format_numbers <- function(x) as.character(x) # Keep whole numbers
  adjust_value <- 1
}

# Build legend
legend_html <- paste0(
  "<div style='display: flex; flex-direction: column;'>",
  paste0(
    sapply(1:(length(breaks_numeric) - 1), function(i) {
      lower_bound <- breaks_numeric[i]
      upper_bound <- if (i == length(breaks_numeric) - 1) breaks_numeric[i + 1] else breaks_numeric[i + 1] - adjust_value

      # Check if the first class has an identical range (e.g., 1 - 1)
      if (i == 1 && lower_bound == upper_bound) {
        label_text <- paste0(format_numbers(lower_bound), " letter")
      } else {
        label_text <- paste0(format_numbers(lower_bound), " - ", format_numbers(upper_bound), " letters")
      }

      paste0(
        "<div style='display: flex; align-items: center; margin-bottom: 5px;'>",
        "<div style='width: ", line_widths[i] * 2, "px; height: 5px; background-color: #C3161F; margin-right: 10px;'></div>",
        "<span>", label_text, "</span>",
        "</div>"
      )
    }),
    collapse = ""
  ),
  "</div>"
)

# Add legend to map
m <- m %>%
  addControl(legend_html, position = "bottomright")

setwd("../leaflet_maps/")

# Save the map and display it
saveWidget(m, file = "nodes_edges_for_epp_sent_to_pirck_colour.html", selfcontained = TRUE)
m
