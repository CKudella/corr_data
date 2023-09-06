SELECT *
FROM budé_cdb_v1.letters
WHERE send_date_computable1 = send_date_computable2
  AND send_date_has_range = '1'
