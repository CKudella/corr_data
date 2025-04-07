SELECT send_date_year1 AS 'Year',
       COUNT(DISTINCT sender_id) AS 'Number of correspondents writing letters to Erasmus this year'
FROM era_cdb.letters
WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
GROUP BY send_date_year1
