SELECT *
FROM era_cdb_v3.letters
WHERE letter_no_in_edition LIKE '%[CWE]%'
  AND letter_no_in_edition NOT LIKE '%[CDE]%'
  AND letter_no_in_edition NOT LIKE '%[ALLEN]%'
