require(tidyverse)
require(leaflet)
require(classInt) # for Jenks algorithm
require(htmlwidgets)
require(leaflet.extras) # Provides addEasyButton()
require(htmltools) # For custom legend

# Set working directory
getwd()
setwd("../..")

# Read data
data_pirck <- read.csv("pirckheimer/query_results/no_epp_per_loc/no_epp_per_loc_sent_to_pirck_with_geocoordinates.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))
data_era <- read.csv("erasmus/query_results/no_epp_per_loc/no_epp_per_loc_sent_to_era_with_geocoordinates.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))
locations_both <- intersect(data_pirck$Location, data_era$Location)
# In both
both <- merge(
  data_pirck[data_pirck$Location %in% locations_both, ],
  data_era[data_era$Location %in% locations_both, ],
  by = "Location.Name", suffixes = c(".pirck", ".era")
)

# Combine the datasets for bounding box calculation
combined_coords <- rbind(
  data_pirck[, c("Latitude", "Longitude")],
  data_era[, c("Latitude", "Longitude")]
)

# Mapbox API Key
mapbox_api_key <- "pk.eyJ1IjoiY2t1ZGVsbGEiLCJhIjoiY2locnN5ejZuMDAxandza3M4cGtzeXlqYSJ9.olxAQeWGTw_6slIVh4i6Cg"

# Create initial map bounds
min_lat <- min(combined_coords$Latitude, na.rm = TRUE)
max_lat <- max(combined_coords$Latitude, na.rm = TRUE)
min_lng <- min(combined_coords$Longitude, na.rm = TRUE)
max_lng <- max(combined_coords$Longitude, na.rm = TRUE)

# Create map
m <- leaflet() %>%
  addProviderTiles(
    provider = "MapBox",
    options = providerTileOptions(
      id = "ckudella/clq3qbtz2004101peb0psb016",
      accessToken = mapbox_api_key
    )
  ) %>%
  addCircleMarkers(
    data = data_pirck,
    lng = ~Longitude,
    lat = ~Latitude,
    popup = paste("<b>", data_pirck$Location.Name, "</b><br>Number of letters sent to Pirckheimer: ", data_pirck$Number.of.Letters.sent.from.this.location.TO.Pirckheimer),
    group = "Locations from which letters were sent to Pirckheimer",
    label = ~Location.Name,
    radius = 3,
    fillColor = "#d5ab5b",
    fillOpacity = 0.7,
    weight = 1,
    opacity = 1,
    color = "#000000",
    stroke = TRUE
  ) %>%
  addCircleMarkers(
    data = data_era,
    lng = ~Longitude,
    lat = ~Latitude,
    popup = paste("<b>", data_era$Location.Name, "</b><br>Number of letters sent to Erasmus: ", data_era$Number.of.letters.sent.from.this.location.to.Erasmus),
    group = "Locations from which letters were sent to Erasmus",
    label = ~Location.Name,
    radius = 6,
    fillColor = NA,
    fillOpacity = 0,
    weight = 1,
    opacity = 1,
    color = "#3c93af",
    stroke = TRUE
  ) %>%
  addCircleMarkers(
    data = both,
    lng = ~Longitude.pirck,
    lat = ~Latitude.pirck,
    group = "Locations from which letters were sent both to Pirckheimer and Erasmus",
    label = ~Location.Name,
    radius = 3,
    fillColor = "#C3161F",
    fillOpacity = 0.7,
    weight = 1,
    opacity = 1,
    color = "#000000",
    stroke = TRUE
  ) %>%
  addLayersControl(
    overlayGroups = c("Locations from which letters were sent to Erasmus", "Locations from which letters were sent to Pirckheimer", "Locations from which letters were sent both to Pirckheimer and Erasmus"),
    options = layersControlOptions(collapsed = FALSE)
  ) %>%
  fitBounds(min_lng, min_lat, max_lng, max_lat) %>% # Set initial zoom
  addScaleBar(position = "bottomleft", options = scaleBarOptions(metric = TRUE, imperial = FALSE)) %>%
  addSearchFeatures(
    targetGroups = c("Locations from which letters were sent to Erasmus", "Locations from which letters were sent to Pirckheimer", "Locations from which letters were sent both to Pirckheimer and Erasmus"),
    options = searchFeaturesOptions(
      zoom = 10,
      openPopup = TRUE,
      position = "topleft"
    )
  ) %>%
  addEasyButton(
    easyButton(
      icon = "fa-globe", # Globe icon for reset
      title = "Reset Zoom",
      onClick = JS("function(btn, map){ map.fitBounds(map.initialBounds); }") # Reset zoom to initial bounds
    )
  ) %>%
  onRender(JS("
    function(el, x) {
      var map = this; // Ensure 'this' refers to the Leaflet map object
      setTimeout(function() {
        if (map.getBounds) {
          map.initialBounds = map.getBounds();
        } else {
          console.error('Error: getBounds() function is not available.');
        }
      }, 1000); // Wait 1 second to ensure map is fully initialized
    }
  "))

# Build the legend
legend_html <- paste0(
  "<div style='display: flex; align-items: center; margin-bottom: 5px;'>",
  "<div style='width: 6px; height: 6px; background-color: #d5ab5b; border: 1px solid #000000; border-radius: 50%; margin-right: 8px;'></div>",
  "Locations from which letters were sent to Pirckheimer",
  "</div>",
  
  "<div style='display: flex; align-items: center; margin-bottom: 5px;'>",
  "<div style='width: 8px; height: 8px; border: 2px solid #3c93af; border-radius: 50%; background-color: transparent; margin-right: 8px;'></div>",
  "Locations from which letters were sent to Erasmus",
  "</div>",
  
  "<div style='display: flex; align-items: center;'>",
  "<div style='width: 6px; height: 6px; background-color: #C3161F; border: 1px solid #000000; border-radius: 50%; margin-right: 8px;'></div>",
  " Locations from which letters were sent both to Pirckheimer and Erasmus",
  "</div>",
  
  "</div>"
)

# Add the legend to the map
m <- m %>%
  addControl(legend_html, position = "bottomright")


setwd("intersections_pirckheimer_erasmus/leaflet_maps")

# Save map as HTML file
saveWidget(m, file = "comp_locs_sent_to_era_pirck_colour.html", selfcontained = TRUE)

# Display map
m
