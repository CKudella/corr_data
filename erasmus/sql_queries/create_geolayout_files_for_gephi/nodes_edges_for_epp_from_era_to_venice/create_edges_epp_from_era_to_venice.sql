SELECT letters_id,
       source_loc_id AS 'Source',
       target_loc_id AS 'Target'
FROM era_cdb.letters
WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id LIKE 'venice%'
