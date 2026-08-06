library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_loc/no_epp_per_loc_sent_by_era_to_outliers.csv"
output_path <- "../r_plots/no_epp_per_loc/no_epp_per_loc_sent_by_era_to_outliers_heatmap"

location_col <- "locations_name_modern"
year_col     <- "YEAR"
count_col    <- "COUNT"

measure_label <- str_glue("sent by {subject_name} to")

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    location = all_of(location_col),
    year     = all_of(year_col),
    count    = all_of(count_col)
  )

totals <- data |>
  group_by(location) |>
  summarise(total = sum(count, na.rm = TRUE)) |>
  arrange(total)

data <- data |>
  mutate(location = factor(location, levels = totals$location))

# statistics

n_locations <- n_distinct(data$location)
n_years     <- n_distinct(data$year)

cat(str_glue("locations: {n_locations}"), "\n")
cat(str_glue("years represented: {n_years}"), "\n")

# plot

plot_heatmap <- data |>
  ggplot(aes(x = year, y = location, fill = count)) +
  geom_tile(color = "white", linewidth = 0.2) +
  scale_fill_gradient(low = "grey95", high = "black", na.value = "white", name = "Letters") +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1), expand = c(0, 0)) +
  labs(
    title = str_glue("Letters {measure_label} per outlier location over time"),
    subtitle = str_glue("locations ordered by total number of letters {measure_label}"),
    x = "Year", y = NULL
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size = 8),
        panel.grid = element_blank())

plot_heatmap

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_heatmap, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })