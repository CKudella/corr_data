---
title: Details on the Scripts contained in /fragmentation_of_locations/
author: Christoph Kudella
date: 2018-03-03
---

| File | Description |
| :------------- | :------------- |
| locs_with_epp_sent_from_to_era_but_not_vice_versa.sql | This script generates a list of locations for which the dataset records letters sent from those locations to Erasmus but not vice versa. The source and target locations are enriched with geographic coordinates from the locations table. |
| locs_with_epp_sent_to_by_era_but_not_vice_versa.sql | This script generates a list of locations for which the dataset records letters sent by Erasmus to those locations but not vice versa. The source and target locations are enriched with geographic coordinates from the locations table. |
| locs_at_which_epp_written_by_era_and_sent_to_era.sql | This script generates a list of locations for which the dataset records instances of Erasmus both writing letters at these locations and receiving letters written from these locations. |
| locs_at_which_epp_written_by_era_but_none_sent_to_era.sql | This script generates a list of locations for which the dataset records instances of Erasmus writing letters at these locations but not receiving letters written from these locations. |
