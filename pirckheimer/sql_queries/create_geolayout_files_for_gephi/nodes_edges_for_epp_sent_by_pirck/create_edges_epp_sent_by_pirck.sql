SELECT source_loc_id AS 'Source',
       target_loc_id AS 'Target'
FROM letters
WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
  AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id NOT LIKE 'unknown%'
