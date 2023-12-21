SELECT COUNT(*) AS 'Total number of letters in DB that are part of the Gueudet list exluding splits'
FROM budé_cdb_v1.letters
WHERE (letters_id LIKE '%gueudet%'
       OR letter_no_in_edition LIKE '%[Gueudet]%')
  AND letters_id NOT LIKE '%ck2'
ORDER BY letters_id
