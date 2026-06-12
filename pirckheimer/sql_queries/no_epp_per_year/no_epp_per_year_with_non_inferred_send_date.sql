SELECT DISTINCT send_date_year1 AS 'Year',
                COUNT(letters_id) AS 'Number of letters with non-inferred send date sent this year'
FROM wpirck_cdb.letters
WHERE letters_id NOT REGEXP 'ck[2-8]$'
  AND send_date_inferred = '0'
GROUP BY send_date_year1
