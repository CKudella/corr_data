SELECT DISTINCT send_date_year1 AS 'Year',
                COUNT(letters_id) AS 'Number of letters with inferred send date sent to Budé this year'
FROM budé_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2%'
  AND send_date_inferred = '1'
  AND recipient_id = 'budé_guillaume_viaf_105878228'
GROUP BY send_date_year1
