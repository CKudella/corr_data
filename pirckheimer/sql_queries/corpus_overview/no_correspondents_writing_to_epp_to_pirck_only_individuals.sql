SELECT COUNT(DISTINCT sender_id) AS 'Total number correspondents (type: individual) who have written letters to Pirckheimer'
FROM letters,
     correspondents
WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
  AND correspondents.type = 'individual'
