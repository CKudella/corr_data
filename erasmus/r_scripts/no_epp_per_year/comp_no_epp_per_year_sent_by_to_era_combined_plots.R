library(tidyverse)
library(patchwork)
library(scales)

# settings

subject_name <- "Erasmus"

data_path <- "../query_results/no_epp_per_year/comp_no_epp_per_year_sent_by_to_era.csv"
output_path <- "../r_plots/no_epp_per_year/comp_no_epp_per_year_sent_by_to_era_combined_plots"

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
    year          = all_of(year_col),
    n_sent_by_era = all_of(sent_by_col),
    n_sent_to_era = all_of(sent_to_col)
  )

full_years <- tibble(year = 1484:1536)
data <- full_years |>
  left_join(data, by = "year") |>
  mutate(
    n_sent_by_era = replace_na(n_sent_by_era, 0),
    n_sent_to_era = replace_na(n_sent_to_era, 0),
    total         = n_sent_by_era + n_sent_to_era,
    directionality = if_else(total > 0,
                              (n_sent_to_era - n_sent_by_era) / total,
                              NA_real_)
  )

data_long <- data |>
  pivot_longer(cols = c(n_sent_by_era, n_sent_to_era), names_to = "variable", values_to = "value") |>
  mutate(
    variable = factor(variable, levels = c("n_sent_by_era", "n_sent_to_era"),
                       labels = c(str_glue("Sent BY {subject_name}"), str_glue("Sent TO {subject_name}")))
  )

data_nonzero      <- data |> filter(total > 0)
data_long_nonzero <- data_long |> filter(year %in% data_nonzero$year)

# statistics

n_years_nonzero <- nrow(data_nonzero)

cat(str_glue("years with letters: {n_years_nonzero}"), "\n")
cat(str_glue("mean directionality: {round(mean(data_nonzero$directionality, na.rm = TRUE), 2)}"), "\n")

# plot

plot_absolute <- data_long_nonzero |>
  ggplot(aes(x = year, y = value, fill = variable)) +
  geom_bar(stat = "identity", width = 0.8) +
  scale_fill_grey(start = 0.3, end = 0.7, name = NULL) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 2)) +
  scale_y_continuous(labels = comma) +
  labs(
    title = str_glue("Letters sent BY vs. TO {subject_name}, by year"),
    x = NULL, y = "Number of letters"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        legend.position = "bottom")

plot_directionality <- data_nonzero |>
  ggplot(aes(x = year, y = directionality)) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey50", linewidth = 0.4) +
  geom_line(color = "grey60", linewidth = 0.5) +
  geom_point(aes(size = total), alpha = 0.6) +
  scale_size_continuous(name = "Total letters\nthat year", range = c(0.5, 4)) +
  scale_x_continuous(breaks = seq(1484, 1536, by = 1)) +
  scale_y_continuous(limits = c(-1, 1), breaks = seq(-1, 1, 0.5)) +
  labs(
    title = "Directionality: incoming vs. outgoing correspondence",
    subtitle = str_glue("+1 = only incoming (to {subject_name}) \u00b7 -1 = only outgoing (by {subject_name}) \u00b7 point size = reliability (total letters)"),
    x = "Year", y = "Directionality index"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7))

final_plot <- (plot_absolute / plot_directionality) + plot_layout(heights = c(1, 1))

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