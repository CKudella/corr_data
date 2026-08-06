library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_modern_state/comp_no_epp_from_era_to_ms_and_from_ms_to_era.csv"
output_path <- "../r_plots/no_epp_per_modern_state/comp_no_epp_from_era_to_ms_and_from_ms_to_era_barchart"

sent_by_col <- str_glue("Number of letters {subject_name} sent to this modern state")
sent_to_col <- str_glue("Number of letters sent from this modern state to {subject_name}")
state_col   <- "ModernState"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_sent_by = all_of(sent_by_col),
    n_sent_to = all_of(sent_to_col),
    state     = all_of(state_col)
  ) |>
  mutate(total = n_sent_by + n_sent_to) |>
  filter(!is.na(total)) |>
  arrange(desc(total)) |>
  mutate(state = factor(state, levels = state))

data_long <- data |>
  pivot_longer(cols = c(n_sent_by, n_sent_to), names_to = "variable", values_to = "value") |>
  mutate(
    variable = factor(
      variable,
      levels = c("n_sent_by", "n_sent_to"),
      labels = c(
        str_glue("Letters sent by {subject_name} to this state"),
        str_glue("Letters sent to {subject_name} from this state")
      )
    )
  )

# statistics

n_states <- nrow(data)

cat(str_glue("states: {n_states}"), "\n")
cat(str_glue("total letters (both directions): {sum(data$total)}"), "\n")

# plot

dodge_width <- position_dodge(width = 0.9)

plot_barchart <- data_long |>
  ggplot(aes(x = state, y = value, fill = variable)) +
  geom_bar(position = dodge_width, stat = "identity") +
  geom_text(aes(label = value), position = dodge_width, vjust = -0.4, size = 2.6) +
  scale_y_continuous(labels = comma, expand = expansion(mult = c(0, 0.1))) +
  scale_fill_grey(start = 0.3, end = 0.7) +
  labs(
    title = str_glue("Number of letters exchanged between {subject_name} and modern states"),
    subtitle = "states ordered by total number of letters (both directions combined)",
    x = "Modern State",
    y = "Number of letters"
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