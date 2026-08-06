library(tidyverse)
library(broom)
library(scales)

# settings

subject_name <- "Erasmus"

receiving_path <- "../query_results/no_corr_per_year/new_corr_per_year_receiving_from_era.csv"
writing_path   <- "../query_results/no_corr_per_year/new_corr_per_year_writing_to_era.csv"
output_path    <- "../r_plots/no_corr_per_year/comp_new_corr_writing_receiving_to_from_era_logistic_growth_model"

receiving_measure_col <- "NewCorrReceivingFromEra"
writing_measure_col   <- "NewCorrWritingToEra"
year_col              <- "YEAR"

group_receiving_label <- str_glue("Receiving ({subject_name} wrote to)")
group_writing_label   <- str_glue("Writing (wrote to {subject_name})")

# data preparation

data_receiving <- read_csv(receiving_path, na = c("NULL", ""), show_col_types = FALSE) |>
  rename(n_new = all_of(receiving_measure_col), year = all_of(year_col))

data_writing <- read_csv(writing_path, na = c("NULL", ""), show_col_types = FALSE) |>
  rename(n_new = all_of(writing_measure_col), year = all_of(year_col))

full_years <- tibble(year = 1484:1536)

prep_series <- function(df, group_label) {
  full_years |>
    left_join(df, by = "year") |>
    mutate(
      n_new            = replace_na(n_new, 0),
      cumulative_total = cumsum(n_new),
      year_centered    = year - min(year),
      group            = group_label
    )
}

data_receiving <- prep_series(data_receiving, group_receiving_label)
data_writing   <- prep_series(data_writing, group_writing_label)

data_combined <- bind_rows(data_receiving, data_writing) |>
  mutate(group = factor(group), group_idx = as.integer(group))

cat("group index mapping:\n")
print(levels(data_combined$group))

# statistics

fit_single_logistic <- function(df) {
  tryCatch({
    nls(cumulative_total ~ SSlogis(year_centered, Asym, xmid, scal), data = df)
  }, error = function(e) {
    message(str_glue("logistic model did not converge for group: {unique(df$group)} - {e$message}"))
    NULL
  })
}

fit_receiving <- fit_single_logistic(data_receiving)
fit_writing   <- fit_single_logistic(data_writing)

cat("\n--- individual model estimates ---\n")
if (!is.null(fit_receiving)) {
  cat(str_glue("\n{group_receiving_label}:"), "\n")
  print(tidy(fit_receiving))
  print(confint(fit_receiving))
}
if (!is.null(fit_writing)) {
  cat(str_glue("\n{group_writing_label}:"), "\n")
  print(tidy(fit_writing))
  print(confint(fit_writing))
}

start_full <- list(
  Asym = c(coef(fit_receiving)["Asym"], coef(fit_writing)["Asym"]),
  xmid = c(coef(fit_receiving)["xmid"], coef(fit_writing)["xmid"]),
  scal = c(coef(fit_receiving)["scal"], coef(fit_writing)["scal"])
)

fit_full <- nls(
  cumulative_total ~ Asym[group_idx] / (1 + exp((xmid[group_idx] - year_centered) / scal[group_idx])),
  data = data_combined,
  start = start_full
)

cat("\n--- joint (full) model: group-specific parameters ---\n")
print(tidy(fit_full))

fit_reduced_asym <- nls(
  cumulative_total ~ Asym / (1 + exp((xmid[group_idx] - year_centered) / scal[group_idx])),
  data = data_combined,
  start = list(Asym = mean(start_full$Asym), xmid = start_full$xmid, scal = start_full$scal)
)

fit_reduced_xmid <- nls(
  cumulative_total ~ Asym[group_idx] / (1 + exp((xmid - year_centered) / scal[group_idx])),
  data = data_combined,
  start = list(Asym = start_full$Asym, xmid = mean(start_full$xmid), scal = start_full$scal)
)

fit_reduced_scal <- nls(
  cumulative_total ~ Asym[group_idx] / (1 + exp((xmid[group_idx] - year_centered) / scal)),
  data = data_combined,
  start = list(Asym = start_full$Asym, xmid = start_full$xmid, scal = mean(start_full$scal))
)

cat("\n--- f-tests: does this parameter differ between groups? ---\n")
cat("\nasym (saturation level):\n")
print(anova(fit_reduced_asym, fit_full))

cat("\nxmid (inflection point / year of fastest growth):\n")
print(anova(fit_reduced_xmid, fit_full))

cat("\nscal (steepness of growth):\n")
print(anova(fit_reduced_scal, fit_full))

cat("\nnote: since the response variable is a cumulative sum, residuals are\n")
cat("strongly autocorrelated, violating the independence assumption of the\n")
cat("f-test. results should be interpreted as indicative, not as strictly\n")
cat("valid inferential statistics.\n")

full_params <- tidy(fit_full) |>
  mutate(
    parameter = str_extract(term, "^[A-Za-z]+"),
    group_idx = as.integer(str_extract(term, "\\d+$")),
    group     = levels(data_combined$group)[group_idx]
  ) |>
  select(group, parameter, estimate, std.error)

comparison_table <- full_params |>
  pivot_wider(names_from = group, values_from = c(estimate, std.error))

cat("\n--- parameter comparison table ---\n")
print(comparison_table)

data_combined <- data_combined |>
  mutate(fitted_value = predict(fit_full, newdata = data_combined))

# plot

plot_comparison <- data_combined |>
  ggplot(aes(x = year, group = group)) +
  geom_line(aes(y = cumulative_total, linetype = group), color = "grey50", linewidth = 0.6) +
  geom_line(aes(y = fitted_value, linetype = group), color = "black", linewidth = 0.9) +
  scale_linetype_manual(name = NULL, values = setNames(c("solid", "dashed"), levels(data_combined$group))) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(labels = comma) +
  labs(
    title = "Comparison of logistic growth models: incoming vs. outgoing correspondence",
    subtitle = "thin lines = observed cumulative totals \u00b7 thick lines = fitted logistic models",
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