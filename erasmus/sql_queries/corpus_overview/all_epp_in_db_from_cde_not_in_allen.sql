SELECT *
FROM era_cdb.letters
WHERE letter_no_in_edition LIKE '%[CDE]%'
  AND letter_no_in_edition NOT LIKE '%[ALLEN]%'
