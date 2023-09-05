SELECT *
FROM era_cdb_v3.letters
WHERE send_date_year1 > send_date_year2
  OR send_date_computable1 > send_date_computable2
