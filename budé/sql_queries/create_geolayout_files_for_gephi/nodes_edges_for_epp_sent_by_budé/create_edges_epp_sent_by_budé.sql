SELECT source_loc_id AS 'Source',
       target_loc_id AS 'Target'
FROM budé_cdb_v1.letters
WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id NOT LIKE 'unknown%'
