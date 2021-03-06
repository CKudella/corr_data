SELECT DISTINCT send_date_year1 AS 'Year',
                COUNT(letters_id) AS 'Number of letters with inferred send date sent to Erasmus this year'
FROM letters
WHERE letters_id NOT LIKE '%ck2%'
  AND send_date_inferred = '1'
  AND recipient_id = 'erasmus_desiderius_viaf_95982394'
GROUP BY send_date_year1
