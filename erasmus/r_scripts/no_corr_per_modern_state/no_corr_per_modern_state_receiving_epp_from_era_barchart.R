library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_corr_per_modern_state/no_corr_per_modern_state_receiving_epp_from_era.csv"
output_path <- "../r_plots/no_corr_per_modern_state/no_corr_per_modern_state_receiving_epp_from_era_barchart"

measure_col <- str_glue("Number of correspondents who received letters from {subject_name}")
state_col   <- "Modern State"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_correspondents = all_of(measure_col),
    state            = all_of(state_col)
  ) |>
  filter(!is.na(n_correspondents)) |>
  arrange(desc(n_correspondents)) |>
  mutate(state = factor(state, levels = state))

# statistics

n_states <- nrow(data)

cat(str_glue("states: {n_states}"), "\n")
cat(str_glue("total correspondents: {sum(data$n_correspondents)}"), "\n")

# plot

plot_barchart <- data |>
  ggplot(aes(x = state, y = n_correspondents)) +
  geom_bar(stat = "identity", fill = "grey40") +
  geom_text(aes(label = n_correspondents), vjust = -0.4, size = 3) +
  scale_y_continuous(labels = comma, expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = str_glue("Number of correspondents per modern state who received letters from {subject_name}"),
    subtitle = "states ordered by number of correspondents",
    x = "Modern State",
    y = "Number of correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35))

plot_barchart

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_barchart, scale = 1, width = 11.7, height = 8.3,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })