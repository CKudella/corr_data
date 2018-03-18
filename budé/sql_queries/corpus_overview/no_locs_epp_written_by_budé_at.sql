SELECT COUNT(DISTINCT letters.source_loc_id) AS 'Total number of locations from which letters have been sent by Budé'
FROM budé_cdb_v1.letters
WHERE letters_id NOT LIKE '%ck2'
  AND sender_id = 'budé_guillaume_viaf_105878228'
  AND source_loc_id NOT LIKE 'unknown%'
