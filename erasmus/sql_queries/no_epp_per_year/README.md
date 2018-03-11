---
title: Details on the scripts contained in /no_epp_per_year/
author: Christoph Kudella
date: 2018-03-11
---
This folder contains scripts that calculate the number of letters per year according to various criteria.

| File | Description |
| :------------- | :------------- |
| comp_no_epp_per_year_sent_by_to_era.sql | This query calculates both the number of letters sent from Erasmus per year and the inverse. |
| no_epp_per_day_sent_by_era.sql | This query calculates the number of letters sent from Erasmus per day. |
| no_epp_per_day_sent_to_era.sql | This query calculates the number of letters sent to Erasmus per day. |
| no_epp_per_year_send_date_year1.sql | This script calculates the number of letters per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_sent_by_era_send_date_year1.sql | This script calculates the number of letters sent by Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_sent_to_era_send_date_year1.sql | This script calculates the number of letters sent to Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_with_inferred_send_date_sent_by_era.sql | This script calculates the number of letters with an inferred send date sent by Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_with_inferred_send_date_sent_to_era.sql | This script calculates the number of letters with an inferred send date sent to Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_with_non_inferred_send_date_sent_by_era.sql | This script calculates the number of letters with an non-inferred send date sent by Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_with_non_inferred_send_date_sent_to_era.sql | This script calculates the number of letters with an non-inferred send date sent to Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_with_non_inferred_send_date.sql | This script calculates the number of letters with an non-inferred send date in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_pery_year_with_inferred_send_date.sql | This script calculates the number of letters with an inferred send date per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
