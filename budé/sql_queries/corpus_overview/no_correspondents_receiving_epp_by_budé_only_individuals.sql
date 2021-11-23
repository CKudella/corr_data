SELECT COUNT(DISTINCT recipient_id) AS 'Total number of correspondents (type: individual) Budé has written letters to'
FROM budé_cdb_v1.letters,
     budé_cdb_v1.correspondents
WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
  AND correspondents.type = 'individual'
