---
title: Details on the Scripts contained in /fragmentation_of_locations/
author: Christoph Kudella
date: 2018-03-04
---
| File | Description |
| :------------- | :------------- |
| locs_with_epp_sent_from_to_pirck_but_not_vice_versa.sql | This script generates a list of locations for which the dataset records letters sent from those locations to Pirckheimer but not vice versa. The source and target locations are enriched with geographic coordinates from the locations table. |
| locs_with_epp_sent_to_by_pirck_but_not_vice_versa.sql | This script generates a list of locations for which the dataset records letters sent by Pirckheimer to those locations but not vice versa. The source and target locations are enriched with geographic coordinates from the locations table. |
| locs_at_which_epp_written_by_pirck_and_sent_to_pirck.sql | This script generates a list of locations for which the dataset records instances of Pirckheimer both writing letters at these locations and receiving letters written from these locations. |
| locs_at_which_epp_written_by_pirck_but_none_sent_to_pirck.sql | This script generates a list of locations for which the dataset records instances of Pirckheimer writing letters at these locations but not receiving letters written from these locations. |