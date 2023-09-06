SELECT COUNT(DISTINCT letters.source_loc_id) AS 'Total number of locations from which letters have been sent by Erasmus'
FROM era_cdb_v3.letters
WHERE letters_id NOT LIKE '%ck2'
  AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND source_loc_id NOT LIKE 'unknown%'
