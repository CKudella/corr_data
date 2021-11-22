SELECT COUNT(DISTINCT recipient_id) AS 'Total number of correspondents Erasmus has written letters to'
FROM era_cdb_v3.letters
WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
