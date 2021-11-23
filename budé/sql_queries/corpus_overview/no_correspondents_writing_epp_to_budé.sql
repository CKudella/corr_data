SELECT COUNT(DISTINCT sender_id) AS 'Total number of correspondents who have written letters to Budé'
FROM budé_cdb_v1.letters
WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
