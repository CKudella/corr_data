SELECT send_date_year1,
       COUNT(*) AS 'Total number of letters sent to Erasmus this year'
FROM letters
WHERE letters_id NOT LIKE '%ck2'
  AND recipient_id = 'erasmus_desiderius_viaf_95982394'
GROUP BY send_date_year1
