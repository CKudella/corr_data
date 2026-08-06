library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_corr_per_year/new_corr_per_year_receiving_from_era.csv"
output_path <- "../r_plots/no_corr_per_year/new_corr_per_year_receiving_from_era_barchart"

measure_col <- "NewCorrReceivingFromEra"
year_col    <- "YEAR"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_new_correspondents = all_of(measure_col),
    year                 = all_of(year_col)
  )

full_years <- tibble(year = 1484:1536)
data <- full_years |>
  left_join(data, by = "year") |>
  mutate(n_new_correspondents = replace_na(n_new_correspondents, 0))

# statistics

n_total <- sum(data$n_new_correspondents)

cat(str_glue("total new correspondents (receiving): {n_total}"), "\n")

# plot

plot_barchart <- data |>
  ggplot(aes(x = year, y = n_new_correspondents)) +
  geom_bar(stat = "identity", fill = "grey40") +
  geom_text(aes(label = n_new_correspondents), vjust = -0.5, size = 2.5) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 8),
                      expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = str_glue("Number of new correspondents to whom {subject_name} wrote letters, by year"),
    subtitle = str_glue("\"New\" refers to correspondents receiving a letter from {subject_name} for the first time in that year"),
    x = "Year",
    y = "Number of new correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7))

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