SELECT COUNT(*) AS 'Total number of letters sent to Budé'
FROM budé_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2'
  AND recipient_id = 'budé_guillaume_viaf_105878228'
