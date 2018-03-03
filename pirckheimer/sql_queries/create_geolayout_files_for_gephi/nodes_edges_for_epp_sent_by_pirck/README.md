---
title: Details on the scripts contained in /nodes_edges_for_epp_sent_by_pirck/
author: Christoph Kudella
date: 2018-03-03
---
The subfolders in this folder contain SQL-scripts to create nodes- and edges-files for the letters sent by Pirckheimer to be used in Gephi with the GeoLayout plugin.

## create_edges_epp_sent_by_pirck.sql
This script generates an edges file based on the letters table. It includes all the letters written by Pirckheimer and excludes the source and target locations if they are unknown.

## create_nodes_locations_for_epp_sent_by_pirck.sql
This script generates an nodes file based on the locations table. It includes all the locations from which Pirckheimer has written letters and excludes the source and target locations if they are unknown.
