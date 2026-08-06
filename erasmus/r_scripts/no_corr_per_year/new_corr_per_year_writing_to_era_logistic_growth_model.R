library(tidyverse)
library(broom)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_corr_per_year/new_corr_per_year_writing_to_era.csv"
output_path <- "../r_plots/no_corr_per_year/new_corr_per_year_writing_to_era_logistic_growth_model"

measure_col <- "NewCorrWritingToEra"
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
  mutate(
    n_new_correspondents = replace_na(n_new_correspondents, 0),
    cumulative_total      = cumsum(n_new_correspondents),
    year_centered         = year - min(year)
  )

fit_linear <- lm(cumulative_total ~ year_centered, data = data)
data <- data |> mutate(fitted_linear = predict(fit_linear, newdata = data))
r2_linear <- summary(fit_linear)$r.squared

fit_logistic <- tryCatch({
  nls(cumulative_total ~ SSlogis(year_centered, Asym, xmid, scal), data = data)
}, error = function(e) {
  message(str_glue("logistic model did not converge: {e$message}"))
  NULL
})

if (!is.null(fit_logistic)) {
  data <- data |> mutate(fitted_logistic = predict(fit_logistic, newdata = data))

  ss_res <- sum(residuals(fit_logistic)^2)
  ss_tot <- sum((data$cumulative_total - mean(data$cumulative_total))^2)
  r2_logistic <- 1 - ss_res / ss_tot

  model_params  <- tidy(fit_logistic)
  asym_estimate <- round(model_params$estimate[model_params$term == "Asym"], 1)
  xmid_estimate <- round(model_params$estimate[model_params$term == "xmid"] + min(data$year), 1)
} else {
  r2_logistic   <- NA
  asym_estimate <- NA
  xmid_estimate <- NA
}

# statistics

cat("model comparison:\n")
cat(str_glue("  linear model:    r\u00b2 = {round(r2_linear, 3)}"), "\n")
if (!is.null(fit_logistic)) {
  cat(str_glue("  logistic model:  r\u00b2 = {round(r2_logistic, 3)}"), "\n")
  cat(str_glue("  estimated saturation level (asym): {asym_estimate} correspondents"), "\n")
  cat(str_glue("  estimated inflection point (year of fastest growth): {xmid_estimate}"), "\n")
} else {
  cat("  logistic model:  fit failed, see message above\n")
}

# plot

plot_data_long <- data |>
  select(year, cumulative_total, fitted_linear, any_of("fitted_logistic")) |>
  pivot_longer(cols = -year, names_to = "series", values_to = "value") |>
  mutate(series = factor(series,
                          levels = c("cumulative_total", "fitted_linear", "fitted_logistic"),
                          labels = c("Observed", "Linear fit", "Logistic fit")))

plot_comparison <- plot_data_long |>
  ggplot(aes(x = year, y = value, linetype = series, linewidth = series)) +
  geom_line(color = "black") +
  scale_linetype_manual(name = NULL, values = c("Observed" = "solid", "Linear fit" = "dashed", "Logistic fit" = "dotted")) +
  scale_linewidth_manual(name = NULL, values = c("Observed" = 0.9, "Linear fit" = 0.6, "Logistic fit" = 0.8)) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(labels = comma) +
  labs(
    title = str_glue("Cumulative growth of {subject_name}'s correspondent network: model comparison"),
    subtitle = str_glue(
      "Linear fit: R\u00b2 = {round(r2_linear, 3)}",
      if_else(!is.null(fit_logistic),
              str_glue("  \u00b7  Logistic fit: R\u00b2 = {round(r2_logistic, 3)}, estimated saturation \u2248 {asym_estimate} correspondents"),
              "  \u00b7  Logistic fit: did not converge")
    ),
    x = "Year",
    y = "Cumulative total correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7),
    legend.position = "bottom"
  )

plot_comparison

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_comparison, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })