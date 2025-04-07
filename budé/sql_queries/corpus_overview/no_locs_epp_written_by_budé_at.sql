SELECT COUNT(DISTINCT letters.source_loc_id) AS 'Total number of locations from which letters have been sent by Budé'
FROM bude_cdb.letters
WHERE letters_id NOT LIKE '%ck2'
  AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND source_loc_id NOT LIKE 'unknown%'
