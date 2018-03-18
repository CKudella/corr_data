SELECT DISTINCT send_date_year1,
       COUNT(*) AS 'Total number of letters sent this year'
FROM budé_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2'
GROUP BY send_date_year1
