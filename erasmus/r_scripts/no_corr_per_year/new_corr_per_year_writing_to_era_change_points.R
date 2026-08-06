library(tidyverse)
library(changepoint)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_corr_per_year/new_corr_per_year_writing_to_era.csv"
output_path <- "../r_plots/no_corr_per_year/new_corr_per_year_writing_to_era_change_points"

measure_col <- "NewCorrWritingToEra"
year_col    <- "YEAR"

# manual step: adjust after inspecting the elbow plot below
chosen_n_changepoints <- 6

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_new_correspondents = all_of(measure_col),
    year                 = all_of(year_col)
  )

full_years <- tibble(year = 1484:1536)
data <- full_years |>
  left_join(data, by = "year") |>
  mutate(n_new_correspondents = replace_na(n_new_correspondents, 0))

# change-point detection using crops - explores a range of penalty values
# instead of committing to a single, arbitrary penalty (e.g. mbic), allowing
# a data-driven choice of the number of change points via an elbow plot

n <- nrow(data)
pen_min <- log(n)
pen_max <- 10 * log(n)

cpt_crops <- cpt.mean(data$n_new_correspondents, method = "PELT",
                      penalty = "CROPS", pen.value = c(pen_min, pen_max))

cpts_raw <- cpts.full(cpt_crops)
pen_raw  <- pen.value.full(cpt_crops)

if (is.matrix(cpts_raw)) {
  n_segmentations <- nrow(cpts_raw)
  n_changepoints  <- apply(cpts_raw, 1, function(x) sum(!is.na(x)))
} else {
  n_segmentations <- length(cpts_raw)
  n_changepoints  <- lengths(cpts_raw)
}

pen_aligned <- pen_raw[seq_len(n_segmentations)]

crops_summary <- tibble(
  penalty        = pen_aligned,
  n_changepoints = n_changepoints
) |>
  distinct(n_changepoints, .keep_all = TRUE) |>
  arrange(desc(penalty))

# statistics

cat("crops summary (penalty vs. number of change points):\n")
print(crops_summary)

matching_row <- which(n_changepoints == chosen_n_changepoints)[1]

if (is.na(matching_row)) {
  stop(str_glue(
    "no segmentation found with exactly {chosen_n_changepoints} change points. ",
    "available options: {paste(sort(unique(n_changepoints)), collapse = ', ')}"
  ))
}

if (is.matrix(cpts_raw)) {
  cpt_indices <- cpts_raw[matching_row, ]
  cpt_indices <- cpt_indices[!is.na(cpt_indices)]
} else {
  cpt_indices <- cpts_raw[[matching_row]]
}

cpt_years <- data$year[cpt_indices]

cat(str_glue("selected number of change points: {chosen_n_changepoints}"), "\n")
cat(str_glue("detected change points at years: {paste(cpt_years, collapse = ', ')}"), "\n")

segment_bounds <- c(1, cpt_indices, nrow(data))
segments <- tibble(
  start_idx = segment_bounds[-length(segment_bounds)],
  end_idx   = segment_bounds[-1]
) |>
  mutate(
    start_year   = data$year[start_idx],
    end_year     = data$year[pmin(end_idx, nrow(data))],
    segment_mean = map2_dbl(start_idx, end_idx, ~ mean(data$n_new_correspondents[.x:.y]))
  )

cat("\nsegment means:\n")
print(segments |> select(start_year, end_year, segment_mean))

# plot

plot_elbow <- crops_summary |>
  ggplot(aes(x = n_changepoints, y = penalty)) +
  geom_line(color = "grey50") +
  geom_point(size = 2) +
  labs(
    title = "CROPS elbow plot: number of change points vs. penalty",
    subtitle = "choose the number of change points at the 'elbow' (diminishing returns point)",
    x = "Number of change points",
    y = "Penalty value"
  ) +
  theme_bw(base_size = 11)

plot_elbow

plot_changepoints <- data |>
  ggplot(aes(x = year, y = n_new_correspondents)) +
  geom_bar(stat = "identity", fill = "grey60") +
  geom_segment(data = segments,
               aes(x = start_year, xend = end_year, y = segment_mean, yend = segment_mean),
               color = "black", linewidth = 0.9, inherit.aes = FALSE) +
  geom_vline(xintercept = cpt_years, linetype = "dashed", color = "black", linewidth = 0.4, alpha = 0.6) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 6)) +
  labs(
    title = "New correspondents per year: structural breaks (CROPS)",
    subtitle = str_glue(
      "Change points selected via CROPS elbow method (n = {chosen_n_changepoints}) at: ",
      "{paste(cpt_years, collapse = ', ')} \u00b7 horizontal lines = segment means"
    ),
    x = "Year",
    y = "New correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7))

plot_changepoints

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_changepoints, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })