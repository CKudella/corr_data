library(tidyverse)
library(ggrepel)
library(scales)

# settings

subject_name <- "Erasmus"
last_year <- 1536

data_path <- "../query_results/duration_of_correspondence/duration_corr_reciproc.csv"
output_path <- "../r_plots/duration_of_correspondence/duration_corr_reciproc_boxplot_facet_grid_year"

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

n_per_year <- data |>
  count(start_year, name = "n_correspondents")

data <- data |>
  left_join(n_per_year, by = "start_year") |>
  mutate(
    facet_label = str_glue("{start_year} (n={n_correspondents})"),
    facet_label = factor(facet_label, levels = facet_label[order(start_year)] |> unique())
  )

outliers_df <- data |>
  group_by(start_year) |>
  mutate(
    q1          = quantile(duration_years, 0.25),
    q3          = quantile(duration_years, 0.75),
    iqr_val     = IQR(duration_years),
    lower_fence = q1 - 1.5 * iqr_val,
    upper_fence = q3 + 1.5 * iqr_val,
    is_outlier  = duration_years < lower_fence | duration_years > upper_fence
  ) |>
  ungroup() |>
  filter(is_outlier)

# statistics

n_total <- nrow(data)

cat(str_glue("total correspondents: {n_total}"), "\n")
cat(str_glue("years represented: {n_distinct(data$start_year)}"), "\n")
cat(str_glue("outliers flagged: {nrow(outliers_df)}"), "\n")

# plot

plot_facets <- data |>
  ggplot(aes(x = "", y = duration_years)) +
  geom_boxplot(outlier.shape = NA, fill = "grey90") +
  geom_point(aes(shape = single_occasion), alpha = 0.4, size = 1) +
  geom_text_repel(
    data = outliers_df,
    aes(label = name),
    box.padding = 0.5, max.overlaps = Inf, size = 2.3
  ) +
  scale_shape_manual(name = NULL, values = c("FALSE" = 16, "TRUE" = 4),
                      labels = c("FALSE" = "Multi-occasion", "TRUE" = "Single-occasion")) +
  facet_wrap(. ~ facet_label, ncol = 6) +
  labs(
    title = str_glue("Correspondence duration by starting year ({dataset_label})"),
    subtitle = "outlier detection (1.5\u00d7IQR) applied per year \u00b7 n shown in each facet label (interpret with caution for small n)",
    x = NULL,
    y = "Correspondence duration (years)"
  ) +
  theme_bw(base_size = 9) +
  theme(
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    legend.position = "bottom",
    strip.text = element_text(size = 7)
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