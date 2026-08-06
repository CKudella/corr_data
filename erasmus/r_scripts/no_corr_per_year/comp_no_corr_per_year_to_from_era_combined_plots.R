library(tidyverse)
library(ggrepel)
library(patchwork)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_corr_per_year/comp_no_corr_per_year_to_from_era.csv"
output_path <- "../r_plots/no_corr_per_year/comp_no_corr_per_year_to_from_era_combined_plots"

to_col   <- str_glue("Number of correspondents {subject_name} writes to this year")
from_col <- str_glue("Number of correspondents writing letters to {subject_name} this year")
year_col <- "Year"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_to   = all_of(to_col),
    n_from = all_of(from_col),
    year   = all_of(year_col)
  )

full_years <- tibble(year = 1484:1536)
data <- full_years |> left_join(data, by = "year")

data_long <- data |>
  pivot_longer(cols = c(n_to, n_from), names_to = "variable", values_to = "value") |>
  mutate(
    variable = factor(
      variable,
      levels = c("n_to", "n_from"),
      labels = c(
        str_glue("Correspondents to whom {subject_name} wrote letters"),
        str_glue("Correspondents who wrote letters to {subject_name}")
      )
    )
  )

lm_fit <- lm(n_from ~ n_to, data = data, na.action = na.exclude)
data <- data |>
  mutate(resid_std = rstandard(lm_fit), is_outlier = abs(resid_std) > 1.5)

cor_test <- cor.test(data$n_to, data$n_from)
r_value  <- round(unname(cor_test$estimate), 2)
p_value  <- signif(cor_test$p.value, 2)

# statistics

n_years <- n_distinct(data$year)

cat(str_glue("years: {n_years}"), "\n")
cat(str_glue("pearson r = {r_value} (p = {p_value})"), "\n")

# plot

plot_linechart <- data_long |>
  ggplot(aes(x = year, y = value, linetype = variable, shape = variable)) +
  geom_line(linewidth = 0.7, color = "black") +
  geom_point(size = 1.6, color = "black") +
  scale_x_continuous(breaks = seq(1484, 1536, by = 2)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 8)) +
  labs(
    title = "Number of correspondents per year: outgoing vs. incoming correspondence",
    x = "Year", y = "Number of correspondents",
    linetype = NULL, shape = NULL
  ) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7),
    legend.position = "bottom"
  ) +
  guides(linetype = guide_legend(nrow = 2), shape = guide_legend(nrow = 2))

plot_correlation <- data |>
  ggplot(aes(x = n_to, y = n_from)) +
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
    title = "Correlation between outgoing and incoming correspondents per year",
    subtitle = str_glue(
      "Pearson r = {r_value} (p ",
      if_else(p_value < 0.001, "< 0.001", str_glue("= {p_value}")),
      ") \u00b7 labeled points = years deviating most from the linear trend"
    ),
    x = str_glue("Correspondents to whom {subject_name} wrote letters"),
    y = str_glue("Correspondents who wrote letters to {subject_name}")
  ) +
  theme_bw(base_size = 11)

final_plot <- plot_linechart + plot_correlation

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