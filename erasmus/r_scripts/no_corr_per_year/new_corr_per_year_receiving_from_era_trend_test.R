library(tidyverse)
library(Kendall)
library(trend)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_corr_per_year/new_corr_per_year_receiving_from_era.csv"
output_path <- "../r_plots/no_corr_per_year/new_corr_per_year_receiving_from_era_trend_test"

measure_col <- "NewCorrReceivingFromEra"
year_col    <- "YEAR"

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

# statistics

mk_result <- MannKendall(data$n_new_correspondents)
tau_value <- round(mk_result$tau, 3)
p_value   <- signif(mk_result$sl, 3)

cat("mann-kendall trend test:\n")
cat(str_glue("  tau = {tau_value}"), "\n")
cat(str_glue("  p-value = {p_value}"), "\n")
cat(str_glue("  interpretation: {
  if_else(p_value < 0.05,
    if_else(tau_value > 0, 'significant increasing trend', 'significant decreasing trend'),
    'no significant monotonic trend')
}"), "\n")

sens_slope_result <- sens.slope(data$n_new_correspondents)
sens_slope_value  <- round(sens_slope_result$estimates, 3)

cat(str_glue("  sen's slope estimate: {sens_slope_value} new correspondents per year"), "\n")

data <- data |>
  mutate(
    year_index = row_number() - 1,
    sens_line  = median(n_new_correspondents) - sens_slope_value * median(year_index) +
      sens_slope_value * year_index
  )

# plot

plot_trend <- data |>
  ggplot(aes(x = year, y = n_new_correspondents)) +
  geom_bar(stat = "identity", fill = "grey60") +
  geom_line(aes(y = sens_line), color = "black", linewidth = 0.8, linetype = "dashed") +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 6)) +
  labs(
    title = "New correspondents per year: Mann-Kendall trend test",
    subtitle = str_glue(
      "Mann-Kendall tau = {tau_value} (p ",
      if_else(p_value < 0.001, "< 0.001", str_glue("= {p_value}")),
      ")  \u00b7  Sen's slope = {sens_slope_value} new correspondents/year (dashed line)"
    ),
    x = "Year",
    y = "New correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7))

plot_trend

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_trend, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })