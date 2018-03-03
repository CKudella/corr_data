---
title: Details on the scripts contained in /corpus_overview/
author: Christoph Kudella
date: 2018-03-03
---
## Queries that calculate the number of letters in the letters table according to various criteria

### no_epp_in_db_excl_splits.sql
This query calculates the total number of letters contained in the letters table, but excludes splits that have been manually conducted.

### no_epp_in_db_sent_by_pirck_excl_splits.sql
This query calculates the total number of letters sent by Pirckheimer in the letters table, but excludes splits that have been manually conducted.

### no_epp_in_db_sent_to_pirck_excl_splits.sql
This query calculates the total number of letters sent to Pirckheimer in the letters table, but excludes splits that have been manually conducted.

## Queries that calculate the number of locations from/to which letters have been sent according to various criteria

### no_locs_epp_sent_by_pirck_to.sql
This query calculates the total number of locations Pirckheimer has sent letters to.

### no_locs_epp_sent_to_pirck.sql
This query calculates the total number of locations from which letters were sent to Pirckheimer.

### no_locs_epp_written_by_pirck_at_but not_from_to_pirck.sql
This query calculates the total number of locations from which Pirckheimer has sent letters and from which he also received letters.

### no_locs_epp_written_by_pirck_at_but not_from_to_pirck.sql
This query calculates total Number of locations where Pirckheimer sent letters from but from which he did not receive any.

## Quantitative queries regarding the correspondents of Pirckheimer

### no_of_correspondents.sql
This query calculates the total number of correspondents of Pirckheimer.

### no_of_correspondents_only_individuals.sql
This query calculates the total number of correspondents (type: individual) of Pirckheimer.

### no_correspondents_only_epp_by_pirck.sql
This query returns the total number of correspondents who received letters from Pirckheimer but did not write to him.

### no_correspondents_only_individuals_only_epp_by_pirck.sql
This query returns the total number of correspondents (type: individual) who received letters from Pirckheimer but did not write to him.

### no_correspondents_only_epp_to_pirck.sql
This query returns the total number of correspondents who wrote letters to Pirckheimer but did not receive any letters from him.

### no_correspondents_only_individuals_only_epp_to_pirck.sql
This query returns the total number of correspondents (type: individual) who wrote letters to Pirckheimer but did not receive any letters from him.

### no_correspondents_only_individuals_reciproc_epp.sql
This query returns the total number of correspondents (type: individual) who have both written letters to Pirckheimer and received letters from him.

### no_correspondents_receiving_epp_by_pirck.sql
This query returns the total number of correspondents who have received letters from Pirckheimer

### no_correspondents_receiving_epp_by_pirck_only_individuals.sql
This query returns the total number of correspondents total number of correspondents (type: individual) who have received letters from Pirckheimer

### no_correspondents_writing_epp_to_era.sql
This query returns the total number of correspondents who have written to Pirckheimer

### no_correspondents_writing_to_epp_to_pirck_only_individuals.sql
This query returns the total number correspondents (type: individual) that have written to Pirckheimer

### no_corrrespondents_reciproc_epp.sql
This query returns the total number of correspondents who have both written letters to Pirckheimer and received letters from him.

### no_locs_corr_write_epp_from.sql
This query calculates the number of locations the individual correspondents wrote letters from.

### no_locs_corr_receives_epp_at.sql
This query calculates the number of locations the individual correspondents received letters at.
