library(tidyverse)
library(scales)
library(patchwork)

# settings

subject_name <- "Erasmus"
last_year <- 1536

data_path <- "../query_results/duration_of_correspondence/duration_corr_only_epp_to_erasmus.csv"
output_path <- "../r_plots/duration_of_correspondence/duration_corr_only_epp_to_erasmus_by_growth_phase_commbined_plots"

id_col    <- "sender_id"
name_col  <- "name_in_edition"
begin_col <- "Beginning of the correspondence"
end_col   <- "End of the correspondence"

dataset_label <- str_glue("correspondents with only letters TO {subject_name} surviving")

# data preparation

data <- read_csv(
  data_path,
  na = c("NULL", ""),
  show_col_types = FALSE
) |>
  rename(
    id    = all_of(id_col),
    name  = all_of(name_col),
    begin = all_of(begin_col),
    end   = all_of(end_col)
  ) |>
  mutate(
    # shorten name to coe form only, convert all-caps surnames to title case while preserving latin numerals
    name = str_split(name, "//") |> map_chr(1),
    name = str_remove(name, "\\[COE\\]"),
    name = str_trim(name),
    name = str_replace_all(name, "\\b\\p{Lu}{2,}\\b", function(m) {
      if_else(str_detect(m, "^[IVXLCDM]+$"), m, str_to_title(m))
    }),
    begin = as.Date(begin, format = "%Y-%m-%d"),
    end   = as.Date(end, format = "%Y-%m-%d")
  ) |>
  filter(!is.na(begin), !is.na(end)) |>
  mutate(
    start_year      = as.integer(format(begin, "%Y")),
    duration_days   = as.numeric(end - begin),
    duration_years  = duration_days / 365.25,
    max_possible_duration = last_year - start_year,
    relative_duration = if_else(max_possible_duration > 0,
                                 duration_years / max_possible_duration,
                                 NA_real_),
    growth_phase = case_when(
      start_year < 1516                       ~ "Early phase (pre-1516,\nslow growth)",
      start_year >= 1516 & start_year < 1524   ~ "Rapid growth phase\n(1516\u20131524)",
      start_year >= 1524                       ~ "Later phase (1524+,\ncontinued growth)"
    ),
    growth_phase = factor(growth_phase, levels = c(
      "Early phase (pre-1516,\nslow growth)",
      "Rapid growth phase\n(1516\u20131524)",
      "Later phase (1524+,\ncontinued growth)"
    ))
  )

reference_line <- tibble(start_year = 1484:last_year) |>
  mutate(max_possible_duration = last_year - start_year)

# statistics

n_total <- nrow(data)

mean_duration   <- mean(data$duration_years)
median_duration <- median(data$duration_years)

cat(str_glue("total correspondents: {n_total}"), "\n")
cat(str_glue("mean duration (years): {round(mean_duration, 2)}"), "\n")
cat(str_glue("median duration (years): {round(median_duration, 2)}"), "\n\n")

kruskal_raw <- kruskal.test(duration_years ~ growth_phase, data = data)
kruskal_relative <- kruskal.test(
  relative_duration ~ growth_phase,
  data = data |> filter(!is.na(relative_duration))
)

cat(str_glue("kruskal-wallis (raw duration by phase): p = {signif(kruskal_raw$p.value, 3)}"), "\n")
cat(str_glue("kruskal-wallis (relative duration by phase): p = {signif(kruskal_relative$p.value, 3)}"), "\n")

# plot

plot_censoring <- data |>
  ggplot(aes(x = start_year, y = duration_years)) +
  geom_line(data = reference_line, aes(y = max_possible_duration),
            color = "grey50", linetype = "dashed", linewidth = 0.6) +
  geom_point(alpha = 0.4, size = 1.8) +
  scale_x_continuous(breaks = seq(1484, last_year, by = 1)) +
  scale_y_continuous(breaks = pretty_breaks(n = 8)) +
  labs(
    title = str_glue("Correspondence duration by start year ({dataset_label})"),
    subtitle = str_glue(
      "n = {n_total} \u00b7 Mean = {round(mean_duration, 1)} yrs \u00b7 ",
      "Median = {round(median_duration, 1)} yrs \u00b7 ",
      "dashed line = maximum theoretically possible duration (data end in {last_year})"
    ),
    x = "Year correspondence began",
    y = "Observed correspondence duration (years)"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7))

plot_raw_by_phase <- data |>
  ggplot(aes(x = growth_phase, y = duration_years)) +
  geom_boxplot(outlier.shape = NA, fill = "grey90") +
  geom_jitter(width = 0.15, alpha = 0.3, size = 1.2) +
  labs(
    title = str_glue("Raw correspondence duration by growth phase (start year) ({dataset_label})"),
    subtitle = str_glue(
      "Kruskal-Wallis p ",
      if_else(kruskal_raw$p.value < 0.001, "< 0.001", str_glue("= {signif(kruskal_raw$p.value, 3)}")),
      " \u2014 caution: comparison confounded by censoring"
    ),
    x = NULL,
    y = "Observed correspondence duration (years)"
  ) +
  theme_bw(base_size = 11)

plot_relative_by_phase <- data |>
  filter(!is.na(relative_duration)) |>
  ggplot(aes(x = growth_phase, y = relative_duration)) +
  geom_boxplot(outlier.shape = NA, fill = "grey90") +
  geom_jitter(width = 0.15, alpha = 0.3, size = 1.2) +
  scale_y_continuous(labels = percent) +
  labs(
    title = str_glue("Relative correspondence duration by growth phase ({dataset_label})"),
    subtitle = str_glue(
      "duration as % of maximum theoretically possible duration \u00b7 Kruskal-Wallis p ",
      if_else(kruskal_relative$p.value < 0.001, "< 0.001", str_glue("= {signif(kruskal_relative$p.value, 3)}"))
    ),
    x = "Growth phase (based on start year)",
    y = "Relative duration\n(% of maximum possible)"
  ) +
  theme_bw(base_size = 11)

final_plot <- plot_censoring / (plot_raw_by_phase | plot_relative_by_phase)

final_plot

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = final_plot, scale = 1, width = 33.1, height = 23.4,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })