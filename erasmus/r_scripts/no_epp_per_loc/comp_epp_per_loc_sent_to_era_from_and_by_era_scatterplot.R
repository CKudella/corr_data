library(tidyverse)
library(ggrepel)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_loc/comp_epp_per_loc_sent_to_era_from_and_by_era_to.csv"
output_path <- "../r_plots/no_epp_per_loc/comp_epp_per_loc_sent_to_era_from_and_by_era_scatterplot"

x_col        <- "NoLettersWrittenTOErasmus"
y_col        <- "NoLettersWrittenBYErasmusTO"
location_col <- "LocationName"

x_label <- str_glue("Number of letters sent TO {subject_name}")
y_label <- str_glue("Number of letters sent BY {subject_name}")

shared_breaks <- c(1, 5, 10, 20, 40, 60, 90, 130, 170)

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    x        = all_of(x_col),
    y        = all_of(y_col),
    location = all_of(location_col)
  )

fence_x <- quantile(data$x, 0.75, na.rm = TRUE) + 1.5 * IQR(data$x, na.rm = TRUE)
fence_y <- quantile(data$y, 0.75, na.rm = TRUE) + 1.5 * IQR(data$y, na.rm = TRUE)

data <- data |>
  mutate(is_outlier = x > fence_x | y > fence_y)

shared_max <- max(data$x, data$y, na.rm = TRUE)

# statistics

n_locations <- nrow(data)
n_outliers  <- sum(data$is_outlier)

cat(str_glue("locations: {n_locations}"), "\n")
cat(str_glue("outliers flagged: {n_outliers}"), "\n")

# plot

plot_scatter <- data |>
  ggplot(aes(x = x, y = y)) +
  geom_abline(slope = 1, intercept = 0, linetype = "dashed", color = "grey50", linewidth = 0.5) +
  geom_point(aes(color = is_outlier), alpha = 0.5, size = 2) +
  geom_text_repel(
    data = filter(data, is_outlier),
    aes(label = location),
    size = 3, box.padding = 0.6, max.overlaps = Inf, seed = 42
  ) +
  scale_x_continuous(trans = "sqrt", breaks = shared_breaks, limits = c(0, shared_max)) +
  scale_y_continuous(trans = "sqrt", breaks = shared_breaks, limits = c(0, shared_max)) +
  scale_color_manual(values = c("FALSE" = "grey60", "TRUE" = "black"), guide = "none") +
  coord_fixed(ratio = 1) +
  labs(
    title = str_glue("Correspondence between {subject_name} and individual locations: incoming vs. outgoing letters"),
    subtitle = "dashed line = equilibrium (equal number of letters in both directions) \u00b7 square-root scale (identical for both axes)",
    x = x_label,
    y = y_label
  ) +
  theme_bw(base_size = 12)

plot_scatter

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_scatter, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })