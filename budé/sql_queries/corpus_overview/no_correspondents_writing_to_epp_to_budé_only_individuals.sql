SELECT COUNT(DISTINCT sender_id) AS 'Total number of correspondents (type: individual) who have written letters to Budé'
FROM bude_cdb_v1.letters,
     bude_cdb_v1.correspondents
WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
  AND correspondents.type = 'individual'
