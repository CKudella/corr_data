library(tidyverse)
library(scales)

# settings

subject_name <- "Erasmus"
last_year <- 1536

data_path <- "../query_results/duration_of_correspondence/duration_corr_reciproc.csv"
output_path <- "../r_plots/duration_of_correspondence/duration_corr_reciproc_histogram"

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
    single_occasion = duration_days == 0
  )

# statistics

n_total    <- nrow(data)
n_single   <- sum(data$single_occasion)
pct_single <- round(100 * n_single / n_total, 1)

mean_duration   <- mean(data$duration_years)
median_duration <- median(data$duration_years)

cat(str_glue("total correspondents: {n_total}"), "\n")
cat(str_glue("single-occasion contacts: {n_single} ({pct_single}%)"), "\n\n")

cat("duration (years), all correspondents:\n")
print(summary(data$duration_years))

cat("\nduration (years), single-occasion contacts excluded:\n")
print(summary(data$duration_years[!data$single_occasion]))

cat(str_glue("\nmean duration (years): {round(mean_duration, 2)}"), "\n")
cat(str_glue("median duration (years): {round(median_duration, 2)}"), "\n")

# plot

plot_histogram <- data |>
  ggplot(aes(x = duration_years, fill = single_occasion)) +
  geom_histogram(bins = 30, color = "white") +
  geom_vline(aes(xintercept = mean_duration, linetype = "Mean"),
             color = "black", linewidth = 0.6) +
  geom_vline(aes(xintercept = median_duration, linetype = "Median"),
             color = "black", linewidth = 0.6) +
  scale_fill_manual(
    name = NULL,
    values = c("FALSE" = "grey60", "TRUE" = "black"),
    labels = c(
      "FALSE" = "Multi-occasion contacts",
      "TRUE"  = str_glue("Single-occasion contacts (n = {n_single})")
    )
  ) +
  scale_linetype_manual(name = NULL, values = c("Mean" = "dashed", "Median" = "dotted")) +
  scale_x_continuous(breaks = pretty_breaks(n = 8)) +
  labs(
    title = str_glue("Distribution of correspondence duration ({dataset_label})"),
    subtitle = str_glue(
      "n = {n_total} correspondents total \u00b7 ",
      "Mean = {round(mean_duration, 1)} years \u00b7 ",
      "Median = {round(median_duration, 1)} years"
    ),
    x = "Correspondence duration (years)",
    y = "Number of correspondents"
  ) +
  theme_bw(base_size = 11) +
  theme(legend.position = "bottom") +
  guides(fill = guide_legend(nrow = 2))

plot_histogram

# save

c("pdf", "png", "eps", "svg") |>
  walk(function(fmt) {
    ggsave(
      filename = str_glue("{output_path}.{fmt}"),
      plot = plot_histogram, scale = 1, width = 33.1, height = 23.4,
      units = "in", dpi = 600, limitsize = TRUE
    )
  })