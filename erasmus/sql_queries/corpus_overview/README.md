---
title: Details on the scripts contained in /corpus_overview
author: Christoph Kudella
date: 2018-03-03
---
## Queries that calculate the number of letters in the letters table according to various criteria

### no_epp_in_db_excl_splits.sql
This query calculates the total number of letters contained in the letters table, but excludes splits that have been manually conducted.

### no_epp_in_db_sent_by_era_excl_splits.sql
This query calculates the total number of letters sent by Erasmus in the letters table, but excludes splits that have been manually conducted.

### no_epp_in_db_sent_to_era_excl_splits.sql
This query calculates the total number of letters sent to Erasmus in the letters table, but excludes splits that have been manually conducted.

### no_epp_in_db_from_allen_excl_splits.sql
This query calculates the total number of letters from the ALLEN edition contained in the letters table , but excludes splits that have been manually conducted.

### no_epp_in_db_not_from_allen_excl_splits.sql
This query calculates the total number of letters contained in the letters table that are not part of the ALLEN edition , but excludes splits that have been manually conducted.

## Queries that calculate the number of locations from/to which letters have been sent according to various criteria

### no_locs_epp_sent_by_era_to.sql
This query calculates the total number of locations Erasmus has sent letters to.

### no_locs_epp_sent_to_era.sql
This query calculates the total number of locations from which letters were sent to Erasmus.

### no_locs_epp_written_by_era_at_and_from_to_era.sql
This query calculates the total number of locations from which Erasmus has sent letters and from which he also received letters.

### no_locs_epp_written_by_era_at_but not_from_to_era.sql
This query calculates total Number of locations where Erasmus sent letters from but from which he did not receive any.

## Queries that return specific subsets from the letters table

### all_epp_in_db_from_with_a_suffix.sql
This query returns all the the letters from the letters table from the ALLEN edition that carry an A Suffix in their sequential number.

###  all_epp_in_db_from_cde_not_in_allen.sql
This query returns all the letters from the letters table that are contained in the CDE edition but not in the ALLEN edition.

### all_epp_in_db_from_cwe_not_in_allen_or_cde.sql
This query returns all the letters from the letters table that are contained in the CWE edition, but not in the ALLEN and CDE editions.

### all_epp_in_db_not_in_editions.sql
This query returns all the letters from the letters table that are not contained in CWE, ALLEN, or CDE.

### all_epp_in_db_with_a_suffix.sql
This query returns all the letters from the letters table that carry a sequential number with a suffix in their internal id.

## Quantitative queries regarding the correspondents of Erasmus

### no_of_correspondents.sql
This query calculates the total number of correspondents of Erasmus.

### no_of_correspondents_only_individuals.sql
This query calculates the total number of correspondents (type: individual) of Erasmus.

### no_correspondents_only_epp_by_era.sql
This query returns the total number of correspondents who received letters from Erasmus but did not write to him.

### no_correspondents_only_individuals_only_epp_by_era.sql
This query returns the total number of correspondents (type: individual) who received letters from Erasmus but did not write to him.

### no_correspondents_only_epp_to_era.sql
This query returns the total number of correspondents who wrote letters to Erasmus but did not receive any letters from him.

### no_correspondents_only_individuals_only_epp_to_era.sql
This query returns the total number of correspondents (type: individual) who wrote letters to Erasmus but did not receive any letters from him.

### no_correspondents_only_individuals_reciproc_epp.sql
This query returns the total number of correspondents (type: individual) who have both written letters to Erasmus and received letters from him.

### no_correspondents_receiving_epp_by_era.sql
This query returns the total number of correspondents who have received letters from Erasmus

### no_correspondents_receiving_epp_by_era_only_individuals.sql
This query returns the total number of correspondents total number of correspondents (type: individual) who have received letters from Erasmus

### no_correspondents_writing_epp_to_era.sql
This query returns the total number of correspondents who have written to Erasmus

### no_correspondents_writing_to_epp_to_era_only_individuals.sql
This query returns the total number correspondents (type: individual) that have written to Erasmus

### no_corrrespondents_reciproc_epp.sql
This query returns the total number of correspondents who have both written letters to Erasmus and received letters from him.

### no_locs_corr_write_epp_from.sql
This query calculates the number of locations the individual correspondents wrote letters from.

### no_locs_corr_receives_epp_at.sql
This query calculates the number of locations the individual correspondents received letters at.
