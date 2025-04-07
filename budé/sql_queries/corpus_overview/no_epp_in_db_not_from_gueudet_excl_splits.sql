SELECT COUNT(*) AS 'Total number of letters in DB that are not part of the Gueudet list exluding splits'
FROM bude_cdb.letters
WHERE letters_id NOT LIKE '%gueudet%'
  AND letter_no_in_edition NOT LIKE '%[Gueudet]%'
  AND letters_id NOT LIKE '%ck2'
ORDER BY letters_id
