library(tidyverse)
library(ggrepel)
library(patchwork)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_corr_per_loc/no_corr_per_loc_receiving_from_era_with_geocoordinates.csv"
output_path <- "../r_plots/no_corr_per_loc/no_corr_per_loc_receiving_from_era_combined_plots"

measure_col  <- str_glue("Number of correspondents who received at this location letters from {subject_name}")
location_col <- "Location Name Modern"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_letters = all_of(measure_col),
    location  = all_of(location_col)
  ) |>
  arrange(desc(n_letters))

quartiles   <- quantile(data$n_letters, probs = c(0.25, 0.5, 0.75))
iqr_val     <- IQR(data$n_letters)
upper_fence <- quartiles[3] + 1.5 * iqr_val

data <- data |>
  mutate(is_outlier = n_letters > upper_fence)

outliers <- data |> filter(is_outlier) |> arrange(desc(n_letters))

# statistics

n_locations <- nrow(data)
n_outliers  <- nrow(outliers)

mean_letters   <- mean(data$n_letters)
median_letters <- median(data$n_letters)

cat(str_glue("locations: {n_locations}"), "\n")
cat(str_glue("mean correspondents: {round(mean_letters, 1)}"), "\n")
cat(str_glue("median correspondents: {median_letters}"), "\n")
cat(str_glue("outliers (> {round(upper_fence, 1)}): {n_outliers}"), "\n")

# plot

plot_histogram <- data |>
  ggplot(aes(x = n_letters)) +
  geom_histogram(bins = 30, fill = "grey60", color = "white") +
  geom_vline(aes(xintercept = mean_letters, linetype = "Mean"), color = "black", linewidth = 0.6) +
  geom_vline(aes(xintercept = median_letters, linetype = "Median"), color = "black", linewidth = 0.6) +
  scale_linetype_manual(name = NULL, values = c("Mean" = "dashed", "Median" = "dotted")) +
  scale_x_log10(labels = comma) +
  labs(
    title = str_glue("Distribution of correspondents receiving letters from {subject_name}, by location"),
    subtitle = str_glue("Mean = {round(mean_letters, 1)} \u00b7 Median = {median_letters}"),
    x = "Number of correspondents (log-scale)",
    y = "Number of locations"
  ) +
  theme_bw(base_size = 12) +
  theme(panel.grid.minor = element_blank(), legend.position = "bottom")

plot_boxplot <- data |>
  ggplot(aes(x = "", y = n_letters)) +
  geom_boxplot(outlier.shape = NA, width = 0.3, fill = "grey90") +
  geom_point(aes(color = is_outlier, shape = is_outlier), alpha = 0.6, size = 1.8) +
  geom_text_repel(
    data = outliers,
    aes(x = "", y = n_letters, label = location),
    size = 3, max.overlaps = Inf, box.padding = 0.6, seed = 42
  ) +
  scale_color_manual(values = c("FALSE" = "grey60", "TRUE" = "black"), guide = "none") +
  scale_shape_manual(values = c("FALSE" = 16, "TRUE" = 17), guide = "none") +
  scale_y_continuous(labels = comma) +
  labs(
    title = "Locations with an outlying number of correspondents",
    x = NULL,
    y = "Number of correspondents"
  ) +
  theme_bw(base_size = 12) +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

plot_barchart <- outliers |>
  ggplot(aes(x = reorder(location, -n_letters), y = n_letters)) +
  geom_col(fill = "grey40") +
  geom_text(aes(label = n_letters), vjust = -0.4, size = 3.2) +
  scale_y_continuous(expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = str_glue("All {n_outliers} outlier locations (> {round(upper_fence, 1)} correspondents)"),
    x = "Location",
    y = "Number of correspondents"
  ) +
  theme_bw(base_size = 12) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1), panel.grid.major.x = element_blank())

final_plot <- (plot_histogram / plot_barchart | plot_boxplot) +
  plot_layout(widths = c(1.3, 1))

final_plot

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = final_plot, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })