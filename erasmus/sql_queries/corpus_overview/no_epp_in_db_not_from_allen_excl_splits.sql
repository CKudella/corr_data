SELECT COUNT(*) AS 'Total number of letters in DB that are not part of the ALLEN edition exluding splits'
FROM era_cdb_v3.letters
WHERE letters.letter_no_in_edition IS NOT NULL
  AND letters.letter_no_in_edition NOT LIKE '%[ALLEN]%'
  AND letters_id NOT LIKE '%ck2'
