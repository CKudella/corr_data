library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_year/comp_no_epp_per_year_inferred_noninferred.csv"
output_path <- "../r_plots/no_epp_per_year/comp_no_epp_per_year_inferred_noninferred_linechart"

inferred_col     <- "Number of letters with inferred send date"
non_inferred_col <- "Number of letters with non-inferred send date"
year_col         <- "Year"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_inferred     = all_of(inferred_col),
    n_non_inferred = all_of(non_inferred_col),
    year           = all_of(year_col)
  )

full_years <- tibble(year = 1484:1536)
data <- full_years |> left_join(data, by = "year")

data_long <- data |>
  pivot_longer(cols = c(n_inferred, n_non_inferred), names_to = "variable", values_to = "value") |>
  mutate(
    variable = factor(variable, levels = c("n_non_inferred", "n_inferred"),
                       labels = c("Non-inferred send date", "Inferred send date"))
  )

# statistics

n_years <- n_distinct(data$year)

cat(str_glue("years in range: {n_years}"), "\n")

# plot

plot_linechart <- data_long |>
  ggplot(aes(x = year, y = value, linetype = variable, shape = variable)) +
  geom_line(color = "black", linewidth = 0.7) +
  geom_point(color = "black", size = 1.8) +
  scale_linetype_manual(name = NULL, values = c("solid", "dashed")) +
  scale_shape_manual(name = NULL, values = c(16, 1)) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 2)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 8)) +
  labs(
    title = "Letters with inferred vs. non-inferred send dates, by year (all correspondence)",
    x = "Year",
    y = "Number of letters"
  ) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7),
    legend.position = "bottom"
  )

plot_linechart

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_linechart, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })