library(tidyverse)
library(patchwork)
library(scales)

# settings

subject_name <- "Erasmus"

receiving_path <- "../query_results/no_corr_per_year/new_corr_per_year_receiving_from_era.csv"
writing_path   <- "../query_results/no_corr_per_year/new_corr_per_year_writing_to_era.csv"
output_path    <- "../r_plots/no_corr_per_year/comp_new_corr_writing_receiving_to_from_era_directionality_index"

receiving_measure_col <- "NewCorrReceivingFromEra"
writing_measure_col   <- "NewCorrWritingToEra"
year_col              <- "YEAR"

# data preparation

data_receiving <- read_csv(receiving_path, na = c("NULL", ""), show_col_types = FALSE) |>
  rename(n_receiving = all_of(receiving_measure_col), year = all_of(year_col))

data_writing <- read_csv(writing_path, na = c("NULL", ""), show_col_types = FALSE) |>
  rename(n_writing = all_of(writing_measure_col), year = all_of(year_col))

full_years <- tibble(year = 1484:1536)

data <- full_years |>
  left_join(data_receiving, by = "year") |>
  left_join(data_writing, by = "year") |>
  mutate(
    n_receiving = replace_na(n_receiving, 0),
    n_writing   = replace_na(n_writing, 0),
    total_new   = n_writing + n_receiving,
    directionality = if_else(total_new > 0, (n_writing - n_receiving) / total_new, NA_real_),
    cum_writing   = cumsum(n_writing),
    cum_receiving = cumsum(n_receiving),
    cum_total     = cum_writing + cum_receiving,
    cum_directionality = if_else(cum_total > 0, (cum_writing - cum_receiving) / cum_total, NA_real_)
  )

# statistics

final_directionality <- round(tail(data$cum_directionality, 1), 3)

cat(str_glue("overall cumulative directionality (final year, {max(data$year)}): {final_directionality}"), "\n")
cat("  (positive = more new correspondents wrote TO subject overall,\n")
cat("   negative = subject initiated more new contacts overall)\n\n")

cat("years with strongest positive directionality:\n")
data |>
  filter(!is.na(directionality)) |>
  arrange(desc(directionality)) |>
  select(year, n_writing, n_receiving, directionality) |>
  head(5) |>
  print()

cat("\nyears with strongest negative directionality:\n")
data |>
  filter(!is.na(directionality)) |>
  arrange(directionality) |>
  select(year, n_writing, n_receiving, directionality) |>
  head(5) |>
  print()

# plot

plot_yearly <- data |>
  ggplot(aes(x = year, y = directionality)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey50", linewidth = 0.4) +
  geom_line(color = "grey60", linewidth = 0.5, na.rm = TRUE) +
  geom_point(aes(size = total_new), alpha = 0.6, na.rm = TRUE) +
  scale_size_continuous(name = "New correspondents\n(both directions combined)", range = c(0.5, 4)) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(limits = c(-1, 1), breaks = seq(-1, 1, 0.5)) +
  labs(
    title = "Directionality of network growth: who initiates new contacts?",
    subtitle = str_glue("+1 = only new correspondents writing TO {subject_name} \u00b7 -1 = only new correspondents {subject_name} wrote TO \u00b7 point size = reliability (sample size)"),
    x = NULL,
    y = "Directionality index\n(yearly)"
  ) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = "right"
  )

plot_cumulative <- data |>
  ggplot(aes(x = year, y = cum_directionality)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey50", linewidth = 0.4) +
  geom_line(color = "black", linewidth = 0.8, na.rm = TRUE) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(limits = c(-1, 1), breaks = seq(-1, 1, 0.5)) +
  labs(
    x = "Year",
    y = "Directionality index\n(cumulative)"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7))

final_plot <- (plot_yearly / plot_cumulative) +
  plot_layout(heights = c(1, 1), guides = "collect") &
  theme(legend.position = "right")

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