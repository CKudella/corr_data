library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_modern_state/no_epp_per_modern_state_written_by_era_at.csv"
output_path <- "../r_plots/no_epp_per_modern_state/no_epp_per_modern_state_written_by_era_at_barchart"

measure_col <- str_glue("Number of letters written at this modern state by {subject_name}")
state_col   <- "Modern State"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_letters = all_of(measure_col),
    state     = all_of(state_col)
  ) |>
  filter(!is.na(n_letters)) |>
  arrange(desc(n_letters)) |>
  mutate(state = factor(state, levels = state))

# statistics

n_states <- nrow(data)

cat(str_glue("states: {n_states}"), "\n")
cat(str_glue("total letters: {sum(data$n_letters)}"), "\n")

# plot

plot_barchart <- data |>
  ggplot(aes(x = state, y = n_letters)) +
  geom_bar(stat = "identity", fill = "grey40") +
  geom_text(aes(label = n_letters), vjust = -0.4, size = 3) +
  scale_y_continuous(labels = comma, expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = str_glue("Number of letters written BY {subject_name} WHILE located in each modern state"),
    subtitle = "states ordered by number of letters",
    x = "Modern State",
    y = "Number of letters"
  ) +
  theme_bw(base_size = 12) +
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