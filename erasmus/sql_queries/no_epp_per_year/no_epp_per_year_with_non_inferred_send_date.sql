SELECT DISTINCT send_date_year1 AS 'Year',
                COUNT(letters_id) AS 'Number of letters with non-inferred send date sent this year'
FROM era_cdb_v3.letters
WHERE letters_id NOT LIKE '%ck2%'
  AND send_date_inferred = '0'
GROUP BY send_date_year1
ORDER BY send_date_year1 ASC
