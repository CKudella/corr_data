SELECT *
FROM bude_cdb.letters
WHERE send_date_computable1 != send_date_computable2
  AND send_date_has_range = '0'
