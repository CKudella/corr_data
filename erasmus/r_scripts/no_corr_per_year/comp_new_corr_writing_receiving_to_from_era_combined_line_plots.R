library(tidyverse)
library(patchwork)
library(scales)

# settings

subject_name <- "Erasmus"

receiving_path <- "../query_results/no_corr_per_year/new_corr_per_year_receiving_from_era.csv"
writing_path   <- "../query_results/no_corr_per_year/new_corr_per_year_writing_to_era.csv"
output_path    <- "../r_plots/no_corr_per_year/comp_new_corr_writing_receiving_to_from_era_combined_line_plots"

receiving_measure_col <- "NewCorrReceivingFromEra"
writing_measure_col   <- "NewCorrWritingToEra"
year_col              <- "YEAR"

# data preparation

data_receiving <- read_csv(receiving_path, na = c("NULL", ""), show_col_types = FALSE) |>
  rename(n_new = all_of(receiving_measure_col), year = all_of(year_col)) |>
  mutate(group = str_glue("{subject_name} wrote to (new recipients)"))

data_writing <- read_csv(writing_path, na = c("NULL", ""), show_col_types = FALSE) |>
  rename(n_new = all_of(writing_measure_col), year = all_of(year_col)) |>
  mutate(group = str_glue("Wrote to {subject_name} (new senders)"))

full_years <- tibble(year = 1484:1536)

prep_series <- function(df) {
  full_years |>
    left_join(df |> select(year, n_new), by = "year") |>
    mutate(
      n_new            = replace_na(n_new, 0),
      cumulative_total = cumsum(n_new),
      group            = unique(na.omit(df$group))
    )
}

data_combined <- bind_rows(prep_series(data_receiving), prep_series(data_writing)) |>
  mutate(group = factor(group, levels = c(
    str_glue("{subject_name} wrote to (new recipients)"),
    str_glue("Wrote to {subject_name} (new senders)")
  )))

# statistics

n_years <- n_distinct(data_combined$year)

cat(str_glue("years: {n_years}"), "\n")

# plot

plot_yearly <- data_combined |>
  ggplot(aes(x = year, y = n_new, linetype = group, shape = group)) +
  geom_line(color = "black", linewidth = 0.6) +
  geom_point(color = "black", size = 1.5) +
  scale_linetype_manual(name = NULL, values = c("solid", "dashed")) +
  scale_shape_manual(name = NULL, values = c(16, 17)) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 6)) +
  labs(
    title = "Incoming vs. outgoing correspondence: four-curve comparison",
    subtitle = "new correspondents per year (top) and cumulative network size (bottom), by direction",
    x = NULL,
    y = "New correspondents\n(per year)"
  ) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = "bottom"
  )

plot_cumulative <- data_combined |>
  ggplot(aes(x = year, y = cumulative_total, linetype = group)) +
  geom_line(color = "black", linewidth = 0.9) +
  scale_linetype_manual(name = NULL, values = c("solid", "dashed")) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 6)) +
  labs(
    x = "Year",
    y = "Cumulative total\ncorrespondents"
  ) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7),
    legend.position = "none"
  )

final_plot <- (plot_yearly / plot_cumulative) + plot_layout(heights = c(1, 1))

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

# summary

final_values <- data_combined |>
  filter(year == max(year)) |>
  select(group, cumulative_total)

cat(str_glue("final cumulative totals (as of {max(data_combined$year)}):"), "\n")
print(final_values)

gap <- diff(final_values$cumulative_total)
cat(str_glue("\ndifference between the two directions: {abs(gap)} correspondents"), "\n")
cat(str_glue("larger network: {final_values$group[which.max(final_values$cumulative_total)]}"), "\n")