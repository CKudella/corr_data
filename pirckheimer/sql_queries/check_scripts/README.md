---
title: Details on the Scripts contained in /check_scripts/
author: Christoph Kudella
date: 2018-03-03
---
### Scripts that check the **letters** table

| File | Description |
| :------------- | :------------- |
| check_for_alien_letters_in_wpirck_corpus.sql | This script checks the letters table for letters that were neither written nor received by Erasmus. |
| check_for_faulty_senddate_ranges.sql | This script checks the letters table for letters for which a date range as been specified by the boolean operator, but the start and the end of the timeframe are identical. |
| check_for_implausible_letter_send_date_range.sql | This script checks the letters table for letters for which the start date of the send date range has been set to a later date than the end of the same range. |
| check_for_letters_with_missing_month_in send_date_as_marked.sql | This script checks the letters table for letters that carry not information on the month the respective letter was sent in the send_date_as_marked column. |
| check_for_malformed_computable_senddates.sql | This script checks the letters table for letters that carry information in the send_date_computable1 and send_date_computable2 columns that does not conform to the "complete date" specification provided in the W3C "Date and Time Specifications". |
| check_for_missing_senddate_range_operator.SQL | This script checks the letters table for letters that carry a send date range but for which the boolean operator has not been set to "1". |

### Scripts that check the **correspondents** table

| File | Description |
| :------------- | :------------- |
| check_for_all_correspondents_with_missing_dob.sql | This script checks the correspondents table for correspondents for which no date of birth has been specified. |
| check_for_all_correspondents_with_missing_dod.sql | This script checks the correspondents table for correspondents for which no date of death has been specified. |
| check_for_implausible_dob_range.sql | This script checks the correspondents table for correspondents for which the start of the 'year of birth range' is later than the end of the same range. |
| check_for_implausible_dod_range.sql | This script checks the correspondents table for correspondents for which the start of the 'year of death range' is later than the end of the same range. |

### Scripts that check **multiple**> tables

| File | Description |
| :------------- | :------------- |
| check_for_deprecated_correspondents.sql | This script checks based on the letters table whether the correspondents table contains correspondents that are neither sender or recipients of letters of Erasmus. |
| check_for_deprecated_locations.sql | This script checks based on the letters and correspondents tables whether the locations table contains locations that are not referenced in the aforementioned tables. |
