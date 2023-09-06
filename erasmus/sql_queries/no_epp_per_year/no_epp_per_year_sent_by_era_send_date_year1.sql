SELECT send_date_year1,
       COUNT(*) AS 'Total number of letters sent by Erasmus this year'
FROM era_cdb_v3.letters
WHERE letters_id NOT LIKE '%ck2'
  AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY send_date_year1
