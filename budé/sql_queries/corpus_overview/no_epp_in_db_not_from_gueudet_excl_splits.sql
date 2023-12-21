SELECT COUNT(*) AS 'Total number of letters in DB that are not part of the Gueudet list exluding splits'
FROM budé_cdb_v1.letters
WHERE letters_id NOT LIKE '%gueudet%'
  AND letters_id NOT LIKE '%ck2'
ORDER BY letters_id
