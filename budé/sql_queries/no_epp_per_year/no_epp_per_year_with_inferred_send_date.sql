SELECT DISTINCT send_date_year1 AS 'Year',
                COUNT(letters_id) AS 'Number of letters with inferred send date sent this year'
FROM budé_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2%'
  AND send_date_inferred = '1'
GROUP BY send_date_year1
