SELECT DISTINCT send_date_year1 AS 'Year',
                COUNT(letters_id) AS 'Number of letters with non-inferred send date sent this year'
FROM letters
WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
  AND send_date_inferred = '0'
GROUP BY send_date_year1
