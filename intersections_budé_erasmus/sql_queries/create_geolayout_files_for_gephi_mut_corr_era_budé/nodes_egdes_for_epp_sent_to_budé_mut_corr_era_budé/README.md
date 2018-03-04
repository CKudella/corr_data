---
title: Details on the scripts contained in /nodes_egdes_for_epp_sent_to_budé_mut_corr_era_budé/
author: Christoph Kudella
date: 2018-03-04
---
The subfolders in this folder contain SQL-scripts to create nodes- and edges-files for the letters sent to Erasmus to from mutual correspondents of his and Budé to be used in Gephi with the GeoLayout plugin.

## create_edges_epp_sent_to_budé_mut_corr_era_budé.sql
This script generates an edges file based on the letters table. It includes all the letters sent to Budé from mutual correspondents of his and Erasmus and excludes the source and target locations if they are unknown.

## create_nodes_locations_for_epp_sent_to_budé_mut_corr_era_budé.sql
This script generates an nodes file based on the locations table. It includes all the locations where Budé has received letters from mutual correspondents of his and Erasmus and excludes the source and target locations if they are unknown.
