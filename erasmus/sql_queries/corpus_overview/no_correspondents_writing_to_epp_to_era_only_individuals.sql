SELECT COUNT(DISTINCT sender_id) AS 'Total number correspondents (type: individual) who have written letters to Erasmus'
FROM era_cdb.letters,
     era_cdb.correspondents
WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
  AND correspondents.type = 'individual'
