SELECT COUNT(*) AS 'Total number of letters in DB that are not part of the ALLEN edition excluding splits'
FROM era_cdb.letters
WHERE (letters.letter_no_in_edition NOT LIKE '%[ALLEN]%'
       OR letters.letter_no_in_edition IS NULL)
  AND letters_id NOT LIKE '%ck2%'
