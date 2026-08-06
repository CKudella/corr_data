library(tidyverse)
library(leaflet)
library(leaflet.extras)
library(htmlwidgets)
library(classInt)
library(scales)

# compute breaks via boxplot statistics or jenks natural breaks - choose 
# per script depending on which better fits the distribution at hand
compute_breaks <- function(x, method = c("boxplot", "jenks"), n_classes = 4) {
  method <- match.arg(method)
  if (method == "jenks") {
    return(classIntervals(x, n = n_classes, style = "jenks")$brks)
  }
  q3 <- quantile(x, 0.75, na.rm = TRUE)
  box_stats <- boxplot.stats(x)
  # fall back to the upper whisker if there are no outliers at all,
  # avoiding a -Inf result from min() on an empty vector
  outlier_min <- if (length(box_stats$out) > 0) min(box_stats$out) else box_stats$stats[5]
  sort(unique(c(min(x, na.rm = TRUE), q3, outlier_min, max(x, na.rm = TRUE))))
}

# assign each observation to a break-based class, for marker sizing/coloring
assign_class <- function(x, breaks) {
  findInterval(x, breaks, rightmost.closed = TRUE)
}

# build a popup html string for a single marker (vectorized over multiple markers)
build_popup <- function(location_name, description, value) {
  str_glue("<b>{location_name}</b><br>{description}: {value}")
}

# build legend html from a set of breaks, handling singular/plural units and
# decimal vs. whole-number formatting automatically - shape can be "circle"
# (point markers) or "line" (edge weight legends)
build_legend_html <- function(breaks, unit_singular, unit_plural, shape = "circle") {
  breaks <- sort(as.numeric(breaks))
  has_decimals <- any(breaks %% 1 != 0)
  fmt <- if (has_decimals) function(x) sprintf("%.2f", x) else function(x) as.character(round(x))
  adjust <- if (has_decimals) 0.01 else 1

  rows <- map_chr(seq_len(length(breaks) - 1), function(i) {
    lower <- breaks[i]
    upper <- if (i == length(breaks) - 1) breaks[i + 1] else breaks[i + 1] - adjust
    unit  <- if (lower == upper) unit_singular else unit_plural
    label <- if (lower == upper) fmt(lower) else str_glue("{fmt(lower)} - {fmt(upper)}")
    swatch <- if (shape == "circle") {
      str_glue("<div style='width:{i * 5}px; height:{i * 5}px; background-color:#C3161F; border-radius:50%; margin-right:10px;'></div>")
    } else {
      str_glue("<div style='width:{i * 10}px; height:5px; background-color:#C3161F; margin-right:10px;'></div>")
    }
    str_glue("<div style='display:flex; align-items:center; margin-bottom:5px;'>{swatch}<span>{label} {unit}</span></div>")
  })

  str_glue("<div style='display:flex; flex-direction:column;'>{paste(rows, collapse = '')}</div>")
}

# build a simple centered title box for the map
build_title_html <- function(title) {
  str_glue(
    "<div style='width:100%; text-align:center;'>",
    "<h3 style='margin:0; padding:5px; background-color:white; font-size:18px; font-weight:bold;'>{title}</h3>",
    "</div>"
  )
}

# add base map tiles only - must be called BEFORE any data layers
# (addCircleMarkers, addPolylines, addPulseMarkers), since it does not
# reference any marker group and is safe to call first
add_base_tiles <- function(map, mapbox_id, mapbox_token) {
  map |>
    addProviderTiles(
      provider = "MapBox",
      options = providerTileOptions(id = mapbox_id, accessToken = mapbox_token)
    )
}

# add scale bar, search box, and reset-zoom button - must be called AFTER
# all data layers have been added. addSearchFeatures() indexes markers in
# the given group at the time it is called (browser-side); if the target
# group does not exist yet, this throws a javascript error in the browser
# that silently aborts all subsequent leaflet calls in the widget, resulting
# in an empty map with only the base tiles visible and no error message in R
add_map_controls <- function(map, search_group = "Locations") {
  map |>
    addScaleBar(position = "bottomleft", options = scaleBarOptions(metric = TRUE, imperial = FALSE)) |>
    addSearchFeatures(
      targetGroups = search_group,
      options = searchFeaturesOptions(zoom = 10, openPopup = TRUE, position = "topleft")
    ) |>
    addEasyButton(
      easyButton(
        icon = "fa-globe",
        title = "Reset Zoom",
        onClick = JS("function(btn, map){ map.fitBounds(map.initialBounds); }")
      )
    ) |>
    onRender(JS(
      "function(el, x) {
        var map = this;
        setTimeout(function() {
          if (map.getBounds) { map.initialBounds = map.getBounds(); }
        }, 1000);
      }"
    ))
}

# compute map bounds from lat/lng vectors
compute_bounds <- function(lat, lng) {
  list(
    min_lat = min(lat, na.rm = TRUE), max_lat = max(lat, na.rm = TRUE),
    min_lng = min(lng, na.rm = TRUE), max_lng = max(lng, na.rm = TRUE)
  )
}

# save a leaflet widget as a self-contained html file
save_map <- function(map, path) {
  saveWidget(map, file = path, selfcontained = TRUE)
}