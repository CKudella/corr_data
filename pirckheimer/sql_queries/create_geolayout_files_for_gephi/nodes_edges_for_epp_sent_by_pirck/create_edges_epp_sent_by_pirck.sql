SELECT source_loc_id AS 'Source',
       target_loc_id AS 'Target'
FROM wpirck_cdb_v1.letters
WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id NOT LIKE 'unknown%'
