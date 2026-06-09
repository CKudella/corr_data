FROM rocker/geospatial:4.5.1

# Install all R packages required by the corr_data pipelines.
#
# Packages are pinned to a specific CRAN snapshot via Posit Package Manager
# (the date in the URL) so that rebuilding this image always installs the
# same versions. To update a package, change the snapshot date and bump the
# image version tag in your workflow files.
#
# rgexf is no longer available on CRAN for R >= 4.x and is therefore
# installed from the CRAN archive at the last known working version.

RUN R -e 'install.packages( \
    c("leaflet", \
      "leaflet.extras", \
      "svglite", \
      "ggrepel", \
      "patchwork", \
      "lubridate", \
      "classInt", \
      "htmlwidgets", \
      "htmltools", \
      "igraph", \
      "ndtv"), \
    repos = "https://packagemanager.posit.co/cran/2025-06-01")'

RUN R -e 'remotes::install_version( \
    "rgexf", \
    version = "0.16.3", \
    repos = "https://cran.r-project.org", \
    upgrade = "never")'
