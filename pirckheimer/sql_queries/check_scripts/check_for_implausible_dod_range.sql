SELECT *
FROM wpirck_cdb.correspondents
WHERE dod_year1 > dod_year2
  OR dod_computable1 > dod_computable2
