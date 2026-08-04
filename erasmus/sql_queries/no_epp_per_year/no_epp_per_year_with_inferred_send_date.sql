SELECT DISTINCT YEAR(send_date_computable1) AS 'Year',
                COUNT(letters_id) AS 'Number of letters with inferred send date sent this year'
FROM era_cdb.letters
WHERE letters_id NOT LIKE '%ck2%'
  AND send_date_inferred = '1'
GROUP BY YEAR(send_date_computable1)
ORDER BY YEAR(send_date_computable1) ASC
