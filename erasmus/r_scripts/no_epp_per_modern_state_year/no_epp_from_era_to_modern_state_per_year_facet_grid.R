library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_modern_state_year/no_epp_from_era_to_modern_state_per_year.csv"
output_path <- "../r_plots/no_epp_per_modern_state_year/no_epp_from_era_to_modern_state_per_year_facet_grid"

measure_col <- str_glue("Number of letters {subject_name} sent to this modern state this year")
state_col   <- "Modern State"
year_col    <- "Year"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_letters = all_of(measure_col),
    state     = all_of(state_col),
    year      = all_of(year_col)
  ) |>
  filter(!is.na(n_letters))

totals <- data |>
  group_by(state) |>
  summarise(total = sum(n_letters, na.rm = TRUE)) |>
  arrange(desc(total))

data <- data |>
  left_join(totals, by = "state") |>
  mutate(
    state_label = str_glue("{state} (n = {total})"),
    state_label = factor(state_label, levels = str_glue("{totals$state} (n = {totals$total})"))
  )

# statistics

n_states <- n_distinct(data$state)
n_years  <- n_distinct(data$year)

cat(str_glue("states: {n_states}"), "\n")
cat(str_glue("years represented: {n_years}"), "\n")

# plot

plot_facets <- data |>
  ggplot(aes(x = year, y = n_letters)) +
  geom_bar(stat = "identity", fill = "grey30", width = 0.7) +
  labs(
    title = str_glue("Letters sent BY {subject_name} TO each modern state, over time"),
    subtitle = "states ordered by total number of letters received",
    x = "Year",
    y = "Number of letters"
  ) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(breaks = pretty_breaks(n = 4)) +
  facet_grid(state_label ~ .) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, size = 8),
    strip.text.y = element_text(angle = 0, hjust = 0, size = 8),
    panel.grid.minor = element_blank(),
    panel.spacing = unit(0.15, "lines")
  )

plot_facets

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_facets, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })