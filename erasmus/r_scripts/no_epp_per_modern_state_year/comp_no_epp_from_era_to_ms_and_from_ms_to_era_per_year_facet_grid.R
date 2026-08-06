library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_modern_state_year/comp_no_epp_from_era_to_ms_and_from_ms_to_era_per_year.csv"
output_path <- "../r_plots/no_epp_per_modern_state_year/comp_no_epp_from_era_to_ms_and_from_ms_to_era_per_year_facet_grid"

state_col     <- "ModernState"
year_col      <- "Year"
sent_by_col   <- "NoEppSentFromEra"
sent_to_col   <- "NoEppSentToEra"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    state   = all_of(state_col),
    year    = all_of(year_col),
    n_by    = all_of(sent_by_col),
    n_to    = all_of(sent_to_col)
  )

totals <- data |>
  mutate(total_row = rowSums(across(c(n_by, n_to)), na.rm = TRUE)) |>
  group_by(state) |>
  summarise(total = sum(total_row, na.rm = TRUE)) |>
  arrange(desc(total))

data <- data |>
  left_join(totals, by = "state") |>
  mutate(
    state_label = str_glue("{state} (n = {total})"),
    state_label = factor(state_label, levels = str_glue("{totals$state} (n = {totals$total})"))
  )

data_long <- data |>
  pivot_longer(cols = c(n_by, n_to), names_to = "variable", values_to = "value") |>
  mutate(
    variable = factor(
      variable,
      levels = c("n_by", "n_to"),
      labels = c(
        str_glue("Sent BY {subject_name} TO this state"),
        str_glue("Sent TO {subject_name} FROM this state")
      )
    )
  )

# statistics

n_states <- n_distinct(data$state)
n_years  <- n_distinct(data$year)

cat(str_glue("states: {n_states}"), "\n")
cat(str_glue("years represented: {n_years}"), "\n")

# plot

plot_facets <- data_long |>
  ggplot(aes(x = year, y = value, linetype = variable)) +
  geom_line(linewidth = 0.7, color = "black") +
  labs(
    title = str_glue("Letters exchanged between {subject_name} and each modern state, over time"),
    subtitle = "states ordered by total number of letters (both directions combined)",
    x = "Year",
    y = "Number of letters",
    linetype = NULL
  ) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(breaks = pretty_breaks(n = 4)) +
  facet_grid(state_label ~ .) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, size = 8),
    strip.text.y = element_text(angle = 0, hjust = 0, size = 8),
    panel.grid.minor = element_blank(),
    panel.spacing = unit(0.15, "lines"),
    legend.position = "bottom"
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