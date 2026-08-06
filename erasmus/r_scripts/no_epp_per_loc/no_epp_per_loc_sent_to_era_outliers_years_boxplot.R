library(tidyverse)
library(ggrepel)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_loc/no_epp_per_loc_sent_to_era_outliers.csv"
output_path <- "../r_plots/no_epp_per_loc/no_epp_per_loc_sent_to_era_outliers_years_boxplot"

location_col <- "locations_name_modern"
year_col     <- "YEAR"
count_col    <- "COUNT"

measure_label <- str_glue("letters per year sent to {subject_name}")

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
  ) |>
  group_by(location) |>
  mutate(
    q1          = quantile(count, 0.25, na.rm = TRUE),
    q3          = quantile(count, 0.75, na.rm = TRUE),
    iqr_val     = IQR(count, na.rm = TRUE),
    lower_fence = q1 - 1.5 * iqr_val,
    upper_fence = q3 + 1.5 * iqr_val,
    is_outlier  = count < lower_fence | count > upper_fence
  ) |>
  ungroup()

location_order <- data |>
  group_by(location) |>
  summarise(median_count = median(count, na.rm = TRUE)) |>
  arrange(desc(median_count)) |>
  pull(location)

data <- data |>
  mutate(location = factor(location, levels = location_order))

outliers_df <- data |> filter(is_outlier)

# statistics

n_locations <- n_distinct(data$location)
n_outliers  <- nrow(outliers_df)

cat(str_glue("locations: {n_locations}"), "\n")
cat(str_glue("outlier years flagged: {n_outliers}"), "\n")

# plot

plot_boxplot <- data |>
  ggplot(aes(x = location, y = count)) +
  geom_boxplot(outlier.shape = NA, fill = "grey90") +
  geom_point(aes(color = is_outlier, shape = is_outlier),
             alpha = 0.6, size = 1.8,
             position = position_jitter(width = 0.1, height = 0)) +
  geom_text_repel(
    data = outliers_df,
    aes(label = year),
    size = 3, max.overlaps = Inf, box.padding = 0.4, seed = 42
  ) +
  scale_color_manual(values = c("FALSE" = "grey60", "TRUE" = "black"), guide = "none") +
  scale_shape_manual(values = c("FALSE" = 16, "TRUE" = 17), guide = "none") +
  labs(
    title = "Yearly letter counts per outlier location: identifying outlier years",
    subtitle = "outlier years (per location) identified using the 1.5 x IQR rule, calculated separately for each location",
    x = "Location",
    y = str_glue("Number of {measure_label}")
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

plot_boxplot

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_boxplot, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })