library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_year/no_epp_per_day_sent_to_era.csv"
output_path <- "../r_plots/no_epp_per_year/no_epp_per_day_sent_to_era_facet_grid"

measure_col   <- "NoEppSentToEra"
send_date_col <- "send_date_computable1"

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(n_letters = all_of(measure_col)) |>
  mutate(send_date = as.Date(.data[[send_date_col]], format = "%Y-%m-%d")) |>
  filter(!is.na(send_date)) |>
  mutate(
    year  = as.integer(format(send_date, "%Y")),
    month = as.integer(format(send_date, "%m")),
    mday  = as.integer(format(send_date, "%d"))
  )

# statistics

n_total <- sum(data$n_letters, na.rm = TRUE)
n_years <- n_distinct(data$year)

cat(str_glue("total letters: {n_total}"), "\n")
cat(str_glue("years represented: {n_years}"), "\n")

# plot

plot_facets <- data |>
  ggplot(aes(x = mday, y = n_letters)) +
  geom_bar(stat = "identity", fill = "grey30") +
  labs(
    title = str_glue("Letters sent TO {subject_name}, by day, month, and year"),
    x = "Day of month",
    y = "Number of letters"
  ) +
  scale_x_continuous(breaks = seq(0, 30, 10)) +
  scale_y_continuous(labels = comma, breaks = pretty_breaks(n = 4)) +
  facet_grid(year ~ month) +
  theme_bw(base_size = 9) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.35, size = 5),
    axis.text.y = element_text(size = 5),
    strip.text.y = element_text(angle = 0, hjust = 1, size = 6),
    strip.text.x = element_text(size = 6),
    panel.grid.minor = element_blank(),
    panel.spacing = unit(0.05, "lines")
  )

plot_facets

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_facets, scale = 1, width = 33.1, height = 23.4,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })