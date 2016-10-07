SELECT send_date_year1, COUNT(*) AS 'Total Number of letters' from letters WHERE letters_id NOT LIKE '%ck2' GROUP BY send_date_year1
