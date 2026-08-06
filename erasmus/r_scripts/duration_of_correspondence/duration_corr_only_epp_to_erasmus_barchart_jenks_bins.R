library(tidyverse)
library(scales)
library(classInt)

# settings

subject_name <- "Erasmus"
last_year <- 1536

data_path <- "../query_results/duration_of_correspondence/duration_corr_only_epp_to_erasmus.csv"
output_path <- "../r_plots/duration_of_correspondence/duration_corr_only_epp_to_erasmus_barchart_jenks_bins"

id_col    <- "sender_id"
name_col  <- "name_in_edition"
begin_col <- "Beginning of the correspondence"
end_col   <- "End of the correspondence"

dataset_label <- str_glue("correspondents with only letters TO {subject_name} surviving")

n_bins <- 4

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
    single_occasion = duration_days == 0
  )

duration_multi <- data$duration_years[!data$single_occasion]
jenks_result <- classIntervals(duration_multi, n = n_bins, style = "jenks")
bin_edges <- jenks_result$brks
bin_labels <- str_glue("{round(bin_edges[-length(bin_edges)], 1)}\u2013{round(bin_edges[-1], 1)} yrs")

data <- data |>
  mutate(
    duration_category = case_when(
      single_occasion ~ "Single occasion\n(same day)",
      TRUE ~ as.character(cut(duration_years, breaks = bin_edges,
                               include.lowest = TRUE, labels = bin_labels))
    ),
    duration_category = factor(duration_category, levels = c("Single occasion\n(same day)", bin_labels))
  )

# statistics

n_total    <- nrow(data)
n_single   <- sum(data$single_occasion)
pct_single <- round(100 * n_single / n_total, 1)

cat(str_glue("total correspondents: {n_total}"), "\n")
cat(str_glue("single-occasion contacts: {n_single} ({pct_single}%)"), "\n\n")

cat("duration (years), single-occasion contacts excluded:\n")
print(summary(duration_multi))

cat("\nbin edges (jenks natural breaks, years):\n")
print(round(bin_edges, 2))

category_summary <- data |>
  count(duration_category) |>
  mutate(pct = round(100 * n / sum(n), 1))

cat("\ndistribution across duration categories:\n")
print(category_summary)

# plot

plot_categories <- category_summary |>
  ggplot(aes(x = duration_category, y = n)) +
  geom_col(fill = "grey40") +
  geom_text(aes(label = str_glue("{n} ({pct}%)")), vjust = -0.4, size = 3.2) +
  scale_y_continuous(labels = comma, expand = expansion(mult = c(0, 0.15))) +
  labs(
    title = str_glue("Distribution of correspondence duration with Erasmus ({dataset_label})"),
    subtitle = str_glue(
      "n = {n_total} correspondents total \u00b7 ",
      "Jenks natural breaks calculated on multi-occasion contacts only"
    ),
    x = "Duration category",
    y = "Number of correspondents"
  ) +
  theme_bw(base_size = 11)

plot_categories

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_categories, scale = 1, width = 33.1, height = 23.4,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })