library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"
last_year <- 1536

data_path <- "../query_results/duration_of_correspondence/duration_corr_reciproc.csv"
output_path <- "../r_plots/duration_of_correspondence/duration_corr_reciproc_scatterplot"

id_col    <- "Correspondent"
name_col  <- "name_in_edition"
begin_col <- "Beginning of the correspondence"
end_col   <- "End of the correspondence"

dataset_label <- "correspondents with letters in BOTH directions surviving"

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
    duration_days   = as.numeric(end - begin),
    duration_years  = duration_days / 365.25,
    single_occasion = duration_days == 0,
    start_year      = as.integer(format(begin, "%Y"))
  )

reference_line <- tibble(start_year = min(data$start_year):last_year) |>
  mutate(
    max_possible_duration = last_year - start_year,
    begin_ref = as.Date(str_glue("{start_year}-01-01"))
  )

# statistics

n_total <- nrow(data)

mean_duration   <- mean(data$duration_years)
median_duration <- median(data$duration_years)

cat(str_glue("total correspondents: {n_total}"), "\n")
cat(str_glue("mean duration (years): {round(mean_duration, 2)}"), "\n")
cat(str_glue("median duration (years): {round(median_duration, 2)}"), "\n")

# plot

plot_scatter <- data |>
  ggplot(aes(x = begin, y = duration_years)) +
  geom_line(data = reference_line, aes(x = begin_ref, y = max_possible_duration),
            color = "grey50", linetype = "dotdash", linewidth = 0.5,
            inherit.aes = FALSE) +
  geom_point(aes(shape = single_occasion), color = "black", alpha = 0.5, size = 1.8) +
  geom_hline(aes(yintercept = mean_duration, linetype = "Mean"),
             color = "black", linewidth = 0.4) +
  geom_hline(aes(yintercept = median_duration, linetype = "Median"),
             color = "black", linewidth = 0.4) +
  scale_shape_manual(name = NULL, values = c("FALSE" = 16, "TRUE" = 4),
                      labels = c("FALSE" = "Multi-occasion contact", "TRUE" = "Single-occasion contact")) +
  scale_linetype_manual(name = NULL, values = c("Mean" = "dashed", "Median" = "dotted")) +
  scale_x_date(
    breaks = seq(as.Date(str_glue("{min(data$start_year)}-01-01")),
                 as.Date(str_glue("{last_year}-01-01")), by = "1 year"),
    date_labels = "%Y",
    expand = expansion(mult = 0.015)
  ) +
  labs(
    title = str_glue("Correspondence duration by starting year ({dataset_label})"),
    subtitle = str_glue(
      "n = {n_total} correspondents \u00b7 Mean = {round(mean_duration, 1)} yrs \u00b7 ",
      "Median = {round(median_duration, 1)} yrs \u00b7 ",
      "dot-dashed grey line = maximum theoretically possible duration (data end in {last_year})"
    ),
    x = "Year correspondence began",
    y = "Correspondence duration (years)"
  ) +
  theme_bw(base_size = 11) +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.35, size = 7),
        legend.position = "bottom") +
  guides(linetype = guide_legend(order = 1), shape = guide_legend(order = 2))

plot_scatter

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_scatter, scale = 1, width = 33.1, height = 23.4,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })