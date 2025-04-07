SELECT send_date_year1 AS 'Year',
       COUNT(DISTINCT recipient_id) AS 'Number of correspondents Erasmus writes to this year'
FROM era_cdb.letters
WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
GROUP BY send_date_year1
