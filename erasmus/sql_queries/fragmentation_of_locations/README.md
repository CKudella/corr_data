---
title: Details on the Scripts contained in /fragmentation_of_locations/
author: Christoph Kudella
date: 2018-03-03
---

## locs_with_epp_sent_from_to_era_but_not_vice_versa.sql
This script generates a list of all the locations from which letters were sent to Erasmus but to which he sent none. The source and target locations are enriched with geographic coordinates from the locations table.

## locs_with_epp_sent_to_by_era_but_not_vice_versa.sql
This script generates a list of all the locations to which letters were sent by Erasmus but from which he received none. The source and target locations are enriched with geographic coordinates from the locations table.

## locs_at_which_epp_written_by_era_and_sent_to_era.sql
This query returns the names of the locations at which Erasmus has both written letters and received letters from.

## locs_at_which_epp_written_by_era_but_none_sent_to_era.sql
This query returns the names of the locations at which Erasmus has written letters but from which he did not receive any.
