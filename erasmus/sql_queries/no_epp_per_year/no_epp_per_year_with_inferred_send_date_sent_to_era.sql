SELECT DISTINCT send_date_year1 AS 'Year',
                COUNT(letters_id) AS 'Number of letters with inferred send date sent to Erasmus this year'
FROM era_cdb_v3.letters
WHERE letters_id NOT LIKE '%ck2%'
  AND send_date_inferred = '1'
  AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY send_date_year1
