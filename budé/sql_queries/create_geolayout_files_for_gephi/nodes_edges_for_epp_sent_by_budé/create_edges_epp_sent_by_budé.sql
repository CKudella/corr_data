SELECT source_loc_id AS 'Source',
       target_loc_id AS 'Target'
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND letters_id NOT LIKE '%ck2'
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id NOT LIKE 'unknown%'
