SELECT COUNT(*) AS 'Total number of letters in the DB excluding splits'
FROM era_cdb_v3.letters
WHERE letters_id NOT LIKE '%ck2'
