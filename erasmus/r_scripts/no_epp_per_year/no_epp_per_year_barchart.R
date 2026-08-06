library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_year/no_epp_per_year_send_date_year1.csv"
output_path <- "../r_plots/no_epp_per_year/no_epp_per_year_barchart"

measure_col <- "Total number of letters sent this year"
year_col    <- "Year"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    n_letters = all_of(measure_col),
    year      = all_of(year_col)
  )

full_years <- tibble(year = 1484:1536)
data <- full_years |>
  left_join(data, by = "year") |>
  mutate(n_letters = replace_na(n_letters, 0))

# statistics

n_total <- sum(data$n_letters)

cat(str_glue("total letters (all years): {n_total}"), "\n")

# plot

plot_barchart <- data |>
  ggplot(aes(x = year, y = n_letters)) +
  geom_bar(stat = "identity", fill = "grey40") +
  geom_text(aes(label = n_letters), vjust = -0.5, size = 2.5) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 2)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 8),
                      expand = expansion(mult = c(0, 0.1))) +
  labs(
    title = "Total number of letters per year (all correspondence)",
    x = "Year",
    y = "Number of letters"
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