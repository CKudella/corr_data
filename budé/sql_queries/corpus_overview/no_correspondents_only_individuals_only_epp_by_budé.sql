SELECT COUNT(correspondents_id) AS 'Total number of correspondents (type: individual) for whom the dataset contains only letters written to them from Budé but not vice versa'
FROM budé_cdb_v1.correspondents
WHERE correspondents_id IN
    (SELECT DISTINCT recipient_id
     FROM budé_cdb_v1.letters
     WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
       AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
       AND correspondents.type = 'individual')
  AND correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM budé_cdb_v1.letters
     WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
       AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
       AND correspondents.type = 'individual')
