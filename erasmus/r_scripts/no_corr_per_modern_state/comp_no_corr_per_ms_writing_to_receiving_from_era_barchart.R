library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_corr_per_modern_state/comp_no_corr_per_ms_writing_to_receiving_from_era.csv"
output_path <- "../r_plots/no_corr_per_modern_state/comp_no_corr_per_ms_writing_to_receiving_from_era_barchart"

received_col <- str_glue("Number of correspondents who received letters from {subject_name}")
wrote_col    <- str_glue("Number of correspondents who wrote letters to {subject_name}")
state_col    <- "Modern State"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_received = all_of(received_col),
    n_wrote    = all_of(wrote_col),
    state      = all_of(state_col)
  ) |>
  mutate(
    n_received = as.numeric(n_received),
    n_wrote    = as.numeric(n_wrote),
    total      = n_received + n_wrote
  ) |>
  filter(!is.na(total)) |>
  arrange(desc(total)) |>
  mutate(state = factor(state, levels = state))

data_long <- data |>
  pivot_longer(cols = c(n_received, n_wrote), names_to = "variable", values_to = "value") |>
  mutate(
    variable = factor(
      variable,
      levels = c("n_received", "n_wrote"),
      labels = c(
        str_glue("Correspondents who received letters from {subject_name}"),
        str_glue("Correspondents who wrote letters to {subject_name}")
      )
    )
  )

# statistics

n_states <- nrow(data)

cat(str_glue("states: {n_states}"), "\n")
cat(str_glue("total correspondents (both directions): {sum(data$total)}"), "\n")

# plot

dodge_width <- position_dodge(width = 0.9)

plot_barchart <- data_long |>
  ggplot(aes(x = state, y = value, fill = variable)) +
  geom_bar(position = dodge_width, stat = "identity") +
  geom_text(aes(label = value), position = dodge_width, vjust = -0.4, size = 2.8) +
  scale_y_continuous(labels = comma, expand = expansion(mult = c(0, 0.1))) +
  scale_fill_grey(start = 0.3, end = 0.7) +
  labs(
    title = "Number of correspondents per modern state, by direction of correspondence",
    subtitle = "states ordered by total number of correspondents (both directions combined)",
    x = "Modern State",
    y = "Number of correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.35),
    legend.position = "bottom",
    legend.title = element_blank()
  )

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