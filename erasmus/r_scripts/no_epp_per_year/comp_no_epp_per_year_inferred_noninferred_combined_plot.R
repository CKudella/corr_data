library(tidyverse)
library(patchwork)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_year/comp_no_epp_per_year_inferred_noninferred.csv"
output_path <- "../r_plots/no_epp_per_year/comp_no_epp_per_year_inferred_noninferred_combined_plot"

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
data <- full_years |>
  left_join(data, by = "year") |>
  mutate(
    n_inferred     = replace_na(n_inferred, 0),
    n_non_inferred = replace_na(n_non_inferred, 0),
    total          = n_inferred + n_non_inferred
  )

data_long <- data |>
  pivot_longer(cols = c(n_inferred, n_non_inferred), names_to = "variable", values_to = "value") |>
  mutate(
    variable = factor(variable, levels = c("n_non_inferred", "n_inferred"),
                       labels = c("Non-inferred send date", "Inferred send date"))
  )

years_with_data <- data$year[data$total > 0]

# statistics

n_years_total    <- n_distinct(data$year)
n_years_nonzero  <- length(years_with_data)

cat(str_glue("years in range: {n_years_total}"), "\n")
cat(str_glue("years with letters: {n_years_nonzero}"), "\n")

# plot

plot_absolute <- data_long |>
  filter(year %in% years_with_data) |>
  ggplot(aes(x = year, y = value, fill = variable)) +
  geom_bar(stat = "identity", width = 0.8) +
  scale_fill_grey(start = 0.3, end = 0.7, name = NULL) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 2)) +
  scale_y_continuous(labels = comma) +
  labs(
    title = "Letters with inferred vs. non-inferred send dates, by year (all correspondence)",
    x = NULL, y = "Number of letters"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        legend.position = "bottom")

plot_proportion <- data_long |>
  filter(year %in% years_with_data) |>
  ggplot(aes(x = year, y = value, fill = variable)) +
  geom_bar(position = "fill", stat = "identity", width = 0.8) +
  scale_fill_grey(start = 0.3, end = 0.7, name = NULL) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 2)) +
  scale_y_continuous(labels = function(x) paste0(x * 100, "%")) +
  labs(x = "Year", y = "Share of letters") +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7),
        legend.position = "none")

final_plot <- (plot_absolute / plot_proportion) + plot_layout(heights = c(1, 1))

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