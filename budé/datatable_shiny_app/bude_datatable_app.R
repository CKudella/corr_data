# Load necessary packages
library(shiny)
library(readr)
library(DT)
library(dplyr)
library(ggplot2)
library(leaflet)
library(leaflet.extras2)

# Define the UI
ui <- fluidPage(
  # Add Google Fonts link
  tags$head(
    tags$link(
      href = "https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap",
      rel = "stylesheet"
    ),
    # Apply Roboto font to the entire app using custom CSS
    tags$style(HTML("
      body {
        font-family: 'Roboto', sans-serif;
      }
    ")),
    # JavaScript to dynamically set page length based on viewport
    tags$script(HTML("
      $(document).ready(function() {
        function setTablePageLength() {
          var availableHeight = $(window).height() - $('#lettersTable').offset().top - 50; // Adjust offset as needed
          var rowHeight = 30; // Approximate height of a row in pixels
          var numberOfRows = Math.floor(availableHeight / rowHeight);
          Shiny.setInputValue('rowsPerPage', numberOfRows);
        }
        
        $(window).on('resize', setTablePageLength); // Recalculate on window resize
        setTablePageLength(); // Initial call
      });
    "))
  ),
  titlePanel("Budé Query Interface - Proof of Concept"),
  fluidRow(
    style = "height: 100vh;", # Full viewport height

    # The map and bar chart take up the left part of the screen, stacked
    column(
      width = 3,
      leafletOutput("locationMap", height = "50vh"), # Map takes up 50% of the viewport height
      plotOutput("lettersPlot", height = "50vh") # Plot takes up the remaining 50% of the left column
    ),

    # The data table takes up the right part of the screen
    column(
      width = 9,
      DTOutput("lettersTable", height = "100vh") # Data table takes the full height on the right
    )
  )
)

# Define the server logic
server <- function(input, output) {
  # Load data
  letters <- read.csv("../dataset/csv/gbudé_letters.csv",
    fileEncoding = "UTF-8",
    na.strings = c("")
  )

  locations <- read.csv("../dataset/csv/gbudé_locations.csv",
    fileEncoding = "UTF-8",
    na.strings = c("")
  )

  # Select specific columns from letters
  letters_filtered <- letters %>% select(
    letter_no_in_edition, sender_as_marked, recipient_as_marked,
    send_date_year1, send_date_computable1, send_date_as_marked,
    source_loc_id, target_loc_id, letter_language
  ) # Specify the columns you want to keep

  # Reactive expression to get the filtered data
  filtered_data <- reactive({
    req(input$lettersTable_rows_all) # Ensure rows are available
    letters_filtered[input$lettersTable_rows_all, , drop = FALSE]
  })

  # Create a summary of the number of letters per year dynamically
  letters_count <- reactive({
    filtered_data() %>%
      group_by(send_date_year1) %>%
      summarise(count = n(), .groups = "drop")
  })

  # Render DataTable
  output$lettersTable <- renderDT({
    datatable(letters_filtered,
      extensions = "Buttons",
      filter = "top",
      options = list(
        dom = "Bfrtip",
        buttons = c("copy", "csv", "excel", "pdf", "print"),
        pageLength = input$rowsPerPage
      )
    ) # Set pageLength dynamically
  })

  # Render Bar Chart
  output$lettersPlot <- renderPlot({
    ggplot(data = letters_count(), aes(x = factor(send_date_year1), y = count)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      labs(x = "Year", y = "Number of Letters") +
      scale_y_continuous(breaks = seq(0, max(letters_count()$count, na.rm = TRUE), by = 1)) + # Use whole numbers for y-axis
      theme_minimal()
  })

  # Render Leaflet Map with Flow Maps
  output$locationMap <- renderLeaflet({
    # Get the filtered data
    filtered_letters <- filtered_data()

    # Join location data for source locations
    source_locations <- locations %>%
      filter(locations_id %in% filtered_letters$source_loc_id) %>%
      select(locations_id, locations_lat, locations_lng, locations_name_modern) # Ensure modern names are selected

    # Join location data for target locations
    target_locations <- locations %>%
      filter(locations_id %in% filtered_letters$target_loc_id) %>%
      select(locations_id, locations_lat, locations_lng, locations_name_modern) # Ensure modern names are selected

    # Calculate counts for source and target locations
    source_counts <- filtered_letters %>%
      group_by(source_loc_id) %>%
      summarise(source_count = n(), .groups = "drop")

    target_counts <- filtered_letters %>%
      group_by(target_loc_id) %>%
      summarise(target_count = n(), .groups = "drop")

    # Join counts with source and target locations
    source_locations <- source_locations %>%
      left_join(source_counts, by = c("locations_id" = "source_loc_id")) %>%
      rename(locations_name_modern_source = locations_name_modern) # Rename for clarity

    target_locations <- target_locations %>%
      left_join(target_counts, by = c("locations_id" = "target_loc_id")) %>%
      rename(locations_name_modern_target = locations_name_modern) # Rename for clarity

    # Combine source and target locations with filtered letters
    combined_locations <- filtered_letters %>%
      left_join(source_locations, by = c("source_loc_id" = "locations_id")) %>%
      left_join(target_locations,
        by = c("target_loc_id" = "locations_id"),
        suffix = c("_source", "_target")
      ) # Add suffix to differentiate source and target

    # Remove rows with NA coordinates for both source and target
    combined_locations <- combined_locations %>%
      filter(!is.na(locations_lat_source) & !is.na(locations_lng_source) &
        !is.na(locations_lat_target) & !is.na(locations_lng_target))

    # Determine min and max counts
    min_source_count <- min(combined_locations$source_count, na.rm = TRUE)
    max_source_count <- max(combined_locations$source_count, na.rm = TRUE)
    min_target_count <- min(combined_locations$target_count, na.rm = TRUE)
    max_target_count <- max(combined_locations$target_count, na.rm = TRUE)

    # Define min and max circle sizes
    min_size <- 2
    max_size <- 10

    # Normalize source counts to scaled radius
    combined_locations <- combined_locations %>%
      mutate(
        source_radius = min_size + ((source_count - min_source_count) / (max_source_count - min_source_count)) * (max_size - min_size),
        target_radius = min_size + ((target_count - min_target_count) / (max_target_count - min_target_count)) * (max_size - min_size)
      )

    # Calculate the bounds for dynamic zoom
    bounds <- list(
      lng_min = min(c(combined_locations$locations_lng_source, combined_locations$locations_lng_target), na.rm = TRUE),
      lng_max = max(c(combined_locations$locations_lng_source, combined_locations$locations_lng_target), na.rm = TRUE),
      lat_min = min(c(combined_locations$locations_lat_source, combined_locations$locations_lat_target), na.rm = TRUE),
      lat_max = max(c(combined_locations$locations_lat_source, combined_locations$locations_lat_target), na.rm = TRUE)
    )

    # Specify Mapbox API key
    mapbox_api_key <- "pk.eyJ1IjoiY2VzdGEiLCJhIjoiMFo5dmlVZyJ9.Io52RcCMMnYukT77GjDJGA"

    # Create the leaflet map
    leaflet() %>%
      addProviderTiles(
        provider = "MapBox",
        options = providerTileOptions(
          id = "cesta/ckg1piv57010w19putr06104b", # this is the default style used by Palladio
          accessToken = mapbox_api_key
        )
      ) %>%
      # Add source markers
      addCircleMarkers(
        data = combined_locations, lng = ~locations_lng_source, lat = ~locations_lat_source,
        color = "blue", radius = ~source_radius,
        label = ~locations_name_modern_source, popup = ~locations_name_modern_source
      ) %>%
      # Add target markers
      addCircleMarkers(
        data = combined_locations, lng = ~locations_lng_target, lat = ~locations_lat_target,
        color = "red", radius = ~target_radius,
        label = ~locations_name_modern_target, popup = ~locations_name_modern_target
      ) %>%
      # Add polylines for source and target locations
      addPolylines(
        lng = as.numeric(unlist(apply(combined_locations, 1, function(row) c(row["locations_lng_source"], row["locations_lng_target"], NA)))),
        lat = as.numeric(unlist(apply(combined_locations, 1, function(row) c(row["locations_lat_source"], row["locations_lat_target"], NA)))),
        color = "black", weight = 2, opacity = 0.5
      ) %>%
      # Adjust bounds dynamically
      fitBounds(
        lng1 = min(c(combined_locations$locations_lng_source, combined_locations$locations_lng_target), na.rm = TRUE),
        lat1 = min(c(combined_locations$locations_lat_source, combined_locations$locations_lat_target), na.rm = TRUE),
        lng2 = max(c(combined_locations$locations_lng_source, combined_locations$locations_lng_target), na.rm = TRUE),
        lat2 = max(c(combined_locations$locations_lat_source, combined_locations$locations_lat_target), na.rm = TRUE)
      )
  })
}

# Run the application
shinyApp(ui = ui, server = server)
