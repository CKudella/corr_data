library(tidyverse)
library(zoo)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_corr_per_year/new_corr_per_year_writing_to_era.csv"
output_path <- "../r_plots/no_corr_per_year/new_corr_per_year_writing_to_era_moving_average"

measure_col <- "NewCorrWritingToEra"
year_col    <- "YEAR"
window_size <- 5

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
  mutate(
    n_new_correspondents = replace_na(n_new_correspondents, 0),
    # na at the first/last 2 years is expected and left as-is, since a
    # centered average requires data on both sides
    moving_avg = rollmean(n_new_correspondents, k = window_size, fill = NA, align = "center")
  )

# statistics

n_total <- sum(data$n_new_correspondents)

cat(str_glue("total new correspondents: {n_total}"), "\n")
cat(str_glue("moving average window: {window_size} years"), "\n")

# plot

plot_moving_average <- data |>
  ggplot(aes(x = year)) +
  geom_bar(aes(y = n_new_correspondents), stat = "identity", fill = "grey70") +
  geom_line(aes(y = moving_avg), color = "black", linewidth = 0.9, na.rm = TRUE) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 6)) +
  labs(
    title = "New correspondents per year: raw values and smoothed trend",
    subtitle = str_glue("{window_size}-year centered moving average (solid line) overlaid on yearly counts (bars)"),
    x = "Year",
    y = "New correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7))

plot_moving_average

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_moving_average, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })