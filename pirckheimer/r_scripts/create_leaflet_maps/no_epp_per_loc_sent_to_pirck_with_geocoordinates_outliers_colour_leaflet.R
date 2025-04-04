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
data <- read.csv("no_epp_per_loc/no_epp_per_loc_sent_to_pirck_with_geocoordinates.csv", fileEncoding = "UTF-8", na.strings = c("NULL"))

# Determine breaks
median_val <- median(data$Number.of.Letters.sent.from.this.location.TO.Pirckheimer, na.rm = TRUE)
q1 <- quantile(data$Number.of.Letters.sent.from.this.location.TO.Pirckheimer, 0.25, na.rm = TRUE)
q3 <- quantile(data$Number.of.Letters.sent.from.this.location.TO.Pirckheimer, 0.75, na.rm = TRUE)
box_stats <- boxplot.stats(data$Number.of.Letters.sent.from.this.location.TO.Pirckheimer)
upper_whisker <- box_stats$stats[5]
outliers <- min(box_stats$out)

# Define breaks including max value to ensure all data points are included
breaks <- c(
  min(data$Number.of.Letters.sent.from.this.location.TO.Pirckheimer, na.rm = TRUE),
  median_val, q3, outliers, max(data$Number.of.Letters.sent.from.this.location.TO.Pirckheimer, na.rm = TRUE)
)

# Mapbox API Key
mapbox_api_key <- "pk.eyJ1IjoiY2t1ZGVsbGEiLCJhIjoiY2locnN5ejZuMDAxandza3M4cGtzeXlqYSJ9.olxAQeWGTw_6slIVh4i6Cg"

# Create initial map bounds
min_lat <- min(data$Latitude, na.rm = TRUE)
max_lat <- max(data$Latitude, na.rm = TRUE)
min_lng <- min(data$Longitude, na.rm = TRUE)
max_lng <- max(data$Longitude, na.rm = TRUE)

# Make sure that the upper bound of the breaks still falls into the correct class
data$class <- findInterval(data$Number.of.Letters.sent.from.this.location.TO.Pirckheimer, breaks, rightmost.closed = TRUE)

# Create map
m <- leaflet(data) %>%
  addProviderTiles(
    provider = "MapBox",
    options = providerTileOptions(
      id = "ckudella/clq3qbtz2004101peb0psb016",
      accessToken = mapbox_api_key
    )
  ) %>%
  addCircleMarkers(
    lng = ~Longitude,
    lat = ~Latitude,
    popup = paste("<b>", data$Location.Name, "</b><br>Number of letters sent from <br/> this location to Pirckheimer: ", data$Number.of.Letters.sent.from.this.location.TO.Pirckheimer),
    group = "Locations",
    label = ~Location.Name,
    radius = data$class * 3,
    fillColor = "#C3161F",
    fillOpacity = 0.7,
    weight = 1,
    opacity = 1,
    color = "#000000",
    stroke = TRUE
  ) %>%
  fitBounds(min_lng, min_lat, max_lng, max_lat) %>% # Set initial zoom
  addScaleBar(position = "bottomleft", options = scaleBarOptions(metric = TRUE, imperial = FALSE)) %>%
  addSearchFeatures(
    targetGroups = c("Locations"),
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

# Ensure breaks are treated as a numeric vector
breaks_numeric <- as.numeric(breaks)

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
        "<div style='width: ", (i * 5), "px; height: ", (i * 5),
        "px; background-color: #C3161F; border-radius: 50%; margin-right: 10px;'></div>",
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

# Add title to the map
m <- m %>%
  addControl(
    html = "<div style='width: 100%; text-align: center;'>
              <h3 style='margin: 0; padding: 5px; background-color: white; font-size: 18px; font-weight: bold;'>
              Number of letters sent to Pirckheimer from this location</h3>
            </div>",
    position = "topright"
  )

setwd("../leaflet_maps/")

# Save map as HTML file
saveWidget(m, file = "no_epp_per_loc_sent_to_pirck_with_geocoordinates_outliers_colour.html", selfcontained = TRUE)

# Display map
m
