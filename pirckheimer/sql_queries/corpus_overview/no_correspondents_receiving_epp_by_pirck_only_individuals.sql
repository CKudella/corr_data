SELECT COUNT(DISTINCT recipient_id) AS 'Total number of correspondents (type: individual) Pirckheimer has written letters to'
FROM wpirck_cdb.letters,
     correspondents
WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
  AND correspondents.type = 'individual'
