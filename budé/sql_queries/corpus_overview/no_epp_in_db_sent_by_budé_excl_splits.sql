SELECT COUNT(*) AS 'Total number of letters sent by Budé'
FROM budé_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2'
  AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
