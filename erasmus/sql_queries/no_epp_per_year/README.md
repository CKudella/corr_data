---
title: Details on the scripts contained in /no_epp_per_year/
author: Christoph Kudella
date: 2018-03-02
---
This folder contains scripts that calculate the number of letters per year according to various criteria.

| File | Description |
| :------------- | :------------- |
| no_epp_per_year_send_date_year1.sql | This script calculates the number of letters per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_sent_by_era_send_date_year1.sql | This script calculates the number of letters sent by Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_sent_to_era_send_date_year1.sql | This script calculates the number of letters sent to Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_with_inferred_send_date_sent_by_era.sql | This script calculates the number of letters with an inferred send date sent by Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_with_inferred_send_date_sent_to_era.sql | This script calculates the number of letters with an inferred send date sent to Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_with_non_inferred_send_date_sent_by_era.sql | This script calculates the number of letters with an non-inferred send date sent by Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_with_non_inferred_send_date_sent_to_era.sql | This script calculates the number of letters with an non-inferred send date sent to Erasmus per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_per_year_with_non_inferred_send_date.sql | This script calculates the number of letters with an non-inferred send date in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
| no_epp_pery_year_with_inferred_send_date.sql | This script calculates the number of letters with an inferred send date per year in the letters table, excluding manually executed splits. Note that this script relies on the earliest year of sending (i.e. the 'send_date_year1' column). |
