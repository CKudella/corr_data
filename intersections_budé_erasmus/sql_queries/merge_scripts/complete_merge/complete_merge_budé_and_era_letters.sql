SELECT *
FROM era_cdb_v3.letters
UNION ALL
  (SELECT *
   FROM budé_cdb_v1.letters
   WHERE letters_id NOT LIKE '%_cwe_%')
