SELECT COUNT(*) AS 'Total number of letters sent to Budé'
FROM bude_cdb.letters
WHERE letters_id NOT LIKE '%ck2'
  AND recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
