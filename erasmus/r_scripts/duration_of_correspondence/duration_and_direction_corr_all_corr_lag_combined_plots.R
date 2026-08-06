library(tidyverse)
library(ggrepel)
library(patchwork)
library(scales)

# settings

subject_name <- "Erasmus"
last_year <- 1536

data_path <- "../query_results/duration_of_correspondence/duration_and_direction_corr_all_corr.csv"
output_path <- "../r_plots/duration_of_correspondence/duration_and_direction_corr_all_corr_lag_combined_plots"

id_col          <- "correspondents_id"
name_col        <- "name_in_edition"
first_from_col  <- "First letter FROM Erasmus TO this correspondent"
first_to_col    <- "First letter FROM this correspondent TO Erasmus"
has_from_col    <- "Has letters FROM Erasmus"
has_to_col      <- "Has letters TO Erasmus"

dataset_label <- "all correspondents"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    id           = all_of(id_col),
    name         = all_of(name_col),
    first_from   = all_of(first_from_col),
    first_to     = all_of(first_to_col),
    has_from     = all_of(has_from_col),
    has_to       = all_of(has_to_col)
  ) |>
  mutate(
    # shorten name to coe form only, convert all-caps surnames to title case while preserving latin numerals
    name = str_split(name, "//") |> map_chr(1),
    name = str_remove(name, "\\[COE\\]"),
    name = str_trim(name),
    name = str_replace_all(name, "\\b\\p{Lu}{2,}\\b", function(m) {
      if_else(str_detect(m, "^[IVXLCDM]+$"), m, str_to_title(m))
    }),
    first_from = as.Date(first_from, format = "%Y-%m-%d"),
    first_to   = as.Date(first_to, format = "%Y-%m-%d"),
    has_from   = as.logical(has_from),
    has_to     = as.logical(has_to)
  )

data <- data |>
  mutate(
    lag_days  = as.numeric(first_from - first_to),
    lag_years = lag_days / 365.25,
    initiation = case_when(
      has_from & !has_to               ~ "Erasmus only\n(no reply on record)",
      !has_from & has_to               ~ "Correspondent only\n(no reply on record)",
      has_from & has_to & lag_days > 0 ~ "Correspondent wrote first",
      has_from & has_to & lag_days < 0 ~ "Erasmus wrote first",
      has_from & has_to & lag_days == 0 ~ "Same date\n(both directions)",
      TRUE ~ NA_character_
    ),
    initiation = factor(initiation, levels = c(
      "Erasmus wrote first",
      "Same date\n(both directions)",
      "Correspondent wrote first",
      "Erasmus only\n(no reply on record)",
      "Correspondent only\n(no reply on record)"
    ))
  )

data_both <- data |> filter(has_from & has_to)

lag_fence_q   <- quantile(data_both$lag_years, c(0.25, 0.75), na.rm = TRUE)
lag_iqr       <- IQR(data_both$lag_years, na.rm = TRUE)
lag_lower     <- lag_fence_q[1] - 1.5 * lag_iqr
lag_upper     <- lag_fence_q[2] + 1.5 * lag_iqr

data_both <- data_both |>
  mutate(is_outlier = lag_years < lag_lower | lag_years > lag_upper)

outliers_lag <- data_both |> filter(is_outlier)

# statistics

n_total <- nrow(data)

initiation_summary <- data |>
  count(initiation) |>
  mutate(pct = round(100 * n / sum(n), 1))

cat(str_glue("total correspondents: {n_total}"), "\n\n")
cat("distribution by initiation category:\n")
print(initiation_summary)

n_na_initiation <- sum(is.na(data$initiation))

if (n_na_initiation > 0) {
  cat(str_glue("\nnote: {n_na_initiation} correspondent(s) could not be classified (initiation = NA):"), "\n")
  data |>
    filter(is.na(initiation)) |>
    select(name, has_from, has_to, first_from, first_to, lag_days) |>
    print(n = Inf)
  cat("(typically caused by undated letters)\n\n")
}

n_same_date <- sum(data$has_from & data$has_to & data$lag_days == 0, na.rm = TRUE)

if (n_same_date > 0) {
  cat(str_glue("\nnote: {n_same_date} correspondent(s) have identical first-letter dates in both directions:"), "\n")
  data |>
    filter(has_from & has_to & lag_days == 0) |>
    select(name, first_from, first_to, lag_days) |>
    print(n = Inf)
  cat("\n")
}

cat(str_glue("\ncorrespondents with letters in both directions: {nrow(data_both)}"), "\n")

cat("\ndescriptive statistics for lag (years), both-directions correspondents only:\n")
print(summary(data_both$lag_years))

mean_lag   <- mean(data_both$lag_years, na.rm = TRUE)
median_lag <- median(data_both$lag_years, na.rm = TRUE)

cat(str_glue("\nmean lag (years): {round(mean_lag, 2)}"), "\n")
cat(str_glue("median lag (years): {round(median_lag, 2)}"), "\n")
cat(str_glue("outliers in lag: {nrow(outliers_lag)} (fence: {round(lag_lower, 1)} to {round(lag_upper, 1)} years)"), "\n")

# plot

plot_categories <- initiation_summary |>
  ggplot(aes(x = initiation, y = n)) +
  geom_col(fill = "grey40") +
  geom_text(aes(label = str_glue("{n} ({pct}%)")), vjust = -0.4, size = 3.2) +
  scale_y_continuous(labels = comma, expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = str_glue("Who initiates correspondence with Erasmus? ({dataset_label})"),
    subtitle = str_glue("n = {n_total} correspondents total"),
    x = NULL,
    y = "Number of correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(size = 8))

plot_lag_histogram <- data_both |>
  ggplot(aes(x = lag_years)) +
  geom_histogram(bins = 40, fill = "grey60", color = "white") +
  geom_vline(xintercept = 0, color = "grey30", linewidth = 0.5) +
  geom_vline(aes(xintercept = mean_lag, linetype = "Mean"), color = "black", linewidth = 0.6) +
  geom_vline(aes(xintercept = median_lag, linetype = "Median"), color = "black", linewidth = 0.6) +
  scale_linetype_manual(name = NULL, values = c("Mean" = "dashed", "Median" = "dotted")) +
  scale_x_continuous(breaks = pretty_breaks(n = 10)) +
  labs(
    title = str_glue("Distribution of the time lag between first letters in each direction ({dataset_label})"),
    subtitle = str_wrap(str_glue(
      "n = {nrow(data_both)} correspondents with letters in both directions \u00b7 ",
      "positive = correspondent wrote first \u00b7 negative = Erasmus wrote first \u00b7 ",
      "Mean = {round(mean_lag, 1)} yrs \u00b7 Median = {round(median_lag, 1)} yrs"
    ), width = 80),
    x = "Lag (years)",
    y = "Number of correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(legend.position = "bottom")

plot_lag_boxplot <- data_both |>
  ggplot(aes(x = "", y = lag_years)) +
  geom_boxplot(outlier.shape = NA, width = 0.3, fill = "grey90") +
  geom_point(aes(color = is_outlier, shape = is_outlier), alpha = 0.5, size = 1.6) +
  geom_text_repel(
    data = outliers_lag,
    aes(label = name),
    size = 2.8, max.overlaps = Inf, box.padding = 0.5, seed = 42
  ) +
  geom_hline(yintercept = 0, color = "grey30", linewidth = 0.4) +
  scale_color_manual(values = c("FALSE" = "grey60", "TRUE" = "black"), guide = "none") +
  scale_shape_manual(values = c("FALSE" = 16, "TRUE" = 17), guide = "none") +
  labs(
    title = str_glue("Correspondents with extreme lag values ({dataset_label})"),
    x = NULL,
    y = "Lag (years)"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())

final_plot <- (plot_categories / plot_lag_histogram) | plot_lag_boxplot
final_plot <- final_plot + plot_layout(widths = c(2, 2))

final_plot

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = final_plot, scale = 1, width = 33.1, height = 23.4,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })