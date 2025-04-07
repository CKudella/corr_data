SELECT COUNT(*) AS 'Total number of letters in the DB excluding splits'
FROM bude_cdb.letters
WHERE letters_id NOT LIKE '%ck2'
