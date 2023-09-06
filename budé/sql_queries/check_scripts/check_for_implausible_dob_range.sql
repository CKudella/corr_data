SELECT *
FROM budé_cdb_v1.correspondents
WHERE dob_year1 > dob_year2
  OR dob_computable1 > dob_computable2
