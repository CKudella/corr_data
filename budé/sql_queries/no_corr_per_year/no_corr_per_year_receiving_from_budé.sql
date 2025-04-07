SELECT send_date_year1 AS 'Year',
       COUNT(DISTINCT recipient_id) AS 'Number of correspondents Budé writes to this year'
FROM bude_cdb.letters
WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
GROUP BY send_date_year1
