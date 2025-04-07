SELECT COUNT(*) AS 'Total number of letters sent by Erasmus'
FROM era_cdb.letters
WHERE letters_id NOT LIKE '%ck2'
  AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
