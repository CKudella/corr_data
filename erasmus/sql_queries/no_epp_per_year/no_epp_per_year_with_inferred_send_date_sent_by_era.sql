SELECT DISTINCT send_date_year1 AS 'Year',
                COUNT(letters_id) AS 'Number of Letters with inferred send date sent by Erasmus this year'
FROM letters
WHERE letters_id NOT LIKE '%ck2%'
  AND send_date_inferred = '1'
  AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY send_date_year1
