---
title: Details on the scripts contained in /nodes_egdes_for_epp_sent_to_era/
author: Christoph Kudella
date: 2018-03-02
---
The subfolders in this folder contain SQL-scripts to create nodes- and edges-files for the letters sent to Pirckheimer to be used in Gephi with the GeoLayout plugin.

| File | Description |
| :------------- | :------------- |
| create_edges_epp_sent_to_pirck.sql | This script generates an edges file based on the letters table. It includes all the letters written to Pirckheimer and excludes the source and target locations if they are unknown. |
| create_nodes_locations_for_epp_sent_to_pirck.sql | This script generates an nodes file based on the locations table. It includes all the locations where Pirckheimer has received letters and excludes the source and target locations if they are unknown. |
