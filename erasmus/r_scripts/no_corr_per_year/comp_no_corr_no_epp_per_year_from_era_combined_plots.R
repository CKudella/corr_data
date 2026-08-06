library(tidyverse)
library(ggrepel)
library(patchwork)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_corr_per_year/comp_no_corr_no_epp_per_year_from_era.csv"
output_path <- "../r_plots/no_corr_per_year/comp_no_corr_no_epp_per_year_from_era_combined_plots"

correspondents_col <- str_glue("Number of correspondents to whom {subject_name} wrote this year")
letters_col        <- str_glue("Number of letters sent by {subject_name} this year")
year_col           <- "Year"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_correspondents = all_of(correspondents_col),
    n_letters        = all_of(letters_col),
    year             = all_of(year_col)
  )

full_years <- tibble(year = 1484:1536)
data <- full_years |> left_join(data, by = "year")

lm_fit <- lm(n_letters ~ n_correspondents, data = data, na.action = na.exclude)
data <- data |> mutate(resid_std = rstandard(lm_fit))
data <- data |> mutate(is_outlier = abs(resid_std) > 2)

cor_test <- cor.test(data$n_correspondents, data$n_letters)
r_value  <- round(unname(cor_test$estimate), 2)
p_value  <- signif(cor_test$p.value, 2)

# statistics

n_years <- n_distinct(data$year)

cat(str_glue("years: {n_years}"), "\n")
cat(str_glue("pearson r = {r_value} (p = {p_value})"), "\n")

# plot

plot_correspondents <- data |>
  ggplot(aes(x = year, y = n_correspondents)) +
  geom_line(linewidth = 0.7, color = "grey40") +
  geom_point(shape = 1, size = 1.8, stroke = 1) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 2)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 8)) +
  labs(
    title = str_glue("Number of correspondents to whom {subject_name} wrote letters, by year"),
    x = "Year", y = "Number of correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7))

plot_letters <- data |>
  ggplot(aes(x = year, y = n_letters)) +
  geom_line(linewidth = 0.7, color = "grey40") +
  geom_point(shape = 1, size = 1.8, stroke = 1) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 2)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 8)) +
  labs(
    title = str_glue("Number of letters sent by {subject_name}, by year"),
    x = "Year", y = "Number of letters"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7))

plot_correlation <- data |>
  ggplot(aes(x = n_correspondents, y = n_letters)) +
  geom_smooth(method = "lm", se = TRUE, color = "black", fill = "grey70", linewidth = 0.6) +
  geom_point(aes(shape = is_outlier), size = 2, alpha = 0.7) +
  geom_text_repel(
    data = filter(data, is_outlier),
    aes(label = year),
    size = 3, box.padding = 0.6, max.overlaps = Inf, seed = 42
  ) +
  scale_shape_manual(values = c("FALSE" = 16, "TRUE" = 17), guide = "none") +
  scale_x_continuous(labels = comma) +
  scale_y_continuous(labels = comma) +
  labs(
    title = "Correlation between number of correspondents and number of letters per year",
    subtitle = str_glue(
      "Pearson r = {r_value} (p ",
      if_else(p_value < 0.001, "< 0.001", str_glue("= {p_value}")),
      ") \u00b7 labeled points = years deviating most from the linear trend"
    ),
    x = "Number of correspondents",
    y = "Number of letters"
  ) +
  theme_bw(base_size = 11)

final_plot <- (plot_correspondents / plot_letters | plot_correlation) +
  plot_layout(widths = c(1.2, 1))

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