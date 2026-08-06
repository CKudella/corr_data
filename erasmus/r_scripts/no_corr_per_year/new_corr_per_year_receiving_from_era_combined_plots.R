library(tidyverse)
library(patchwork)
library(scales)

# settings

subject_name <- "Erasmus"

new_path   <- "../query_results/no_corr_per_year/new_corr_per_year_receiving_from_era.csv"
total_path <- "../query_results/no_corr_per_year/comp_no_corr_no_epp_per_year_from_era.csv"
output_path <- "../r_plots/no_corr_per_year/new_corr_per_year_receiving_from_era_combined_plots"

new_measure_col   <- "NewCorrReceivingFromEra"
new_year_col      <- "YEAR"
total_measure_col <- str_glue("Number of correspondents to whom {subject_name} wrote this year")
total_year_col    <- "Year"

# data preparation

data_new <- read_csv(new_path, na = c("NULL", ""), show_col_types = FALSE) |>
  rename(n_new_correspondents = all_of(new_measure_col), year = all_of(new_year_col))

data_total <- read_csv(total_path, na = c("NULL", ""), show_col_types = FALSE) |>
  rename(n_total_correspondents = all_of(total_measure_col), year = all_of(total_year_col)) |>
  select(year, n_total_correspondents)

full_years <- tibble(year = 1484:1536)

data <- full_years |>
  left_join(data_new, by = "year") |>
  left_join(data_total, by = "year") |>
  mutate(
    n_new_correspondents   = replace_na(n_new_correspondents, 0),
    n_total_correspondents = replace_na(n_total_correspondents, 0),
    cumulative_total        = cumsum(n_new_correspondents),
    pct_new = if_else(n_total_correspondents > 0,
                       n_new_correspondents / n_total_correspondents * 100,
                       NA_real_)
  )

# statistics

n_total_new <- sum(data$n_new_correspondents)

cat(str_glue("total new correspondents: {n_total_new}"), "\n")
cat(str_glue("final cumulative total: {tail(data$cumulative_total, 1)}"), "\n")

# plot

plot_new <- data |>
  ggplot(aes(x = year, y = n_new_correspondents)) +
  geom_bar(stat = "identity", fill = "grey40") +
  geom_text(aes(label = n_new_correspondents), vjust = -0.5, size = 2.3) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 6),
                      expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = "New correspondents, cumulative network growth, and turnover rate",
    subtitle = str_glue("\"New\" refers to correspondents receiving a letter from {subject_name} for the first time in that year"),
    x = NULL,
    y = "New correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    panel.grid.minor = element_blank()
  )

plot_cumulative <- data |>
  ggplot(aes(x = year, y = cumulative_total)) +
  geom_area(fill = "grey70", color = "black", linewidth = 0.5) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 6),
                      expand = expansion(mult = c(0, 0.05))) +
  labs(
    x = NULL,
    y = "Cumulative total\ncorrespondents"
  ) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    panel.grid.minor = element_blank()
  )

plot_turnover <- data |>
  ggplot(aes(x = year, y = pct_new)) +
  geom_line(color = "black", linewidth = 0.6, na.rm = TRUE) +
  geom_point(size = 1.3, na.rm = TRUE) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(labels = function(x) paste0(x, "%"),
                      breaks = pretty_breaks(n = 6),
                      limits = c(0, 100)) +
  labs(
    x = "Year",
    y = "% new correspondents\n(of all correspondents that year)"
  ) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7),
    panel.grid.minor = element_blank()
  )

final_plot <- (plot_new / plot_cumulative / plot_turnover) +
  plot_layout(heights = c(1, 0.8, 1))

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