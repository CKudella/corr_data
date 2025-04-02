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
data <- read.csv("no_epp_per_loc/avg_no_epp_per_corr_loc_written_by_era_to.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# Determine breaks
median_val <- median(data$Average.Number.of.letters.per.correspondent, na.rm = TRUE)
q1 <- quantile(data$Average.Number.of.letters.per.correspondent, 0.25, na.rm = TRUE)
q3 <- quantile(data$Average.Number.of.letters.per.correspondent, 0.75, na.rm = TRUE)
box_stats <- boxplot.stats(data$Average.Number.of.letters.per.correspondent)
upper_whisker <- box_stats$stats[5]
outliers <- min(box_stats$out)

# Define breaks including max value to ensure all data points are included
breaks <- c(min(data$Average.Number.of.letters.per.correspondent, na.rm = TRUE), 
            median_val, q3, outliers, max(data$Average.Number.of.letters.per.correspondent, na.rm = TRUE))

# Mapbox API Key
mapbox_api_key <- "pk.eyJ1IjoiY2t1ZGVsbGEiLCJhIjoiY2locnN5ejZuMDAxandza3M4cGtzeXlqYSJ9.olxAQeWGTw_6slIVh4i6Cg"

# Create initial map bounds
min_lat <- min(data$Latitude, na.rm = TRUE)
max_lat <- max(data$Latitude, na.rm = TRUE)
min_lng <- min(data$Longitude, na.rm = TRUE)
max_lng <- max(data$Longitude, na.rm = TRUE)

# Normalize intensity for proper weighting (matching QGIS behavior)
data$scaled_intensity <- (data$Average.Number.of.letters.per.correspondent - min(data$Average.Number.of.letters.per.correspondent, na.rm = TRUE)) /
  (max(data$Average.Number.of.letters.per.correspondent, na.rm = TRUE) - min(data$Average.Number.of.letters.per.correspondent, na.rm = TRUE))

# Create the heatmap with the correct intensity values and color gradient
m <- leaflet(data) %>%
  addProviderTiles(
    provider = "MapBox",
    options = providerTileOptions(
      id = "ckudella/clq3qbtz2004101peb0psb016",
      accessToken = mapbox_api_key
    )
  ) %>%
  addHeatmap(
    lng = ~Longitude,
    lat = ~Latitude,
    intensity = ~scaled_intensity,  # Use the original intensity value
    blur = 20,  # Smooth out the heatmap
    minOpacity = 1,
    max = 1,  # Ensures proper scaling
    radius = 10,  # Spread of heat
    gradient = c("#fdcc8a", "#fc8d59", "#e34a33", "#b30000")  # Custom gradient
  ) %>%
  fitBounds(min_lng, min_lat, max_lng, max_lat) %>%
  addScaleBar(position = "bottomleft", options = scaleBarOptions(metric = TRUE, imperial = FALSE)) %>%
  addEasyButton(
    easyButton(
      icon = "fa-globe",
      title = "Reset Zoom",
      onClick = JS("function(btn, map){ map.fitBounds(map.initialBounds); }")
    )
  ) %>%
  addLayersControl(
    overlayGroups = c("Heatmap"), 
    options = layersControlOptions(collapsed = FALSE)
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

# Build heatmap legend with the correct colors
legend_html <- paste0(
  "<div style='padding: 10px; background: white; border-radius: 5px; box-shadow: 0 0 5px rgba(0,0,0,0.3);'>",
  "<strong>Heatmap Intensity</strong><br>",
  "<div style='height: 10px; width: 150px; background: linear-gradient(to right, transparent, #fdcc8a, #fc8d59, #e34a33, #b30000);'></div>",
  "<div style='display: flex; justify-content: space-between; font-size: 12px;'>",
  "<span>Low</span><span>High</span>",
  "</div>",
  "</div>"
)

# Add the legend to the map
m <- m %>%
  addControl(legend_html, position = "bottomright")

# Add title
m <- m %>%
  addControl(
    html = "<div style='width: 100%; text-align: center;'>
              <h3 style='margin: 0; padding: 5px; background-color: white; font-size: 18px; font-weight: bold;'>
              Average Number of Letters per Correspondent by Erasmus</h3>
            </div>",
    position = "topright"
  )

# Save and display
setwd("../leaflet_maps/")
saveWidget(m, file = "avg_no_epp_per_corr_loc_written_by_era_to_colour_heatmap.html", selfcontained = TRUE)

m
