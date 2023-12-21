SELECT COUNT(correspondents_id) AS 'Total number of correspondents (type: individual) for whom the dataset contains only letters sent to them by Pirckheimer but not vice versa'
FROM wpirck_cdb_v1.correspondents
WHERE correspondents_id IN
    (SELECT DISTINCT recipient_id
     FROM wpirck_cdb_v1.letters
     WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
       AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
       AND correspondents.type = 'individual')
  AND correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM wpirck_cdb_v1.letters
     WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
       AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
       AND correspondents.type = 'individual')
