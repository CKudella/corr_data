SELECT source_loc_id AS 'Source',
       target_loc_id AS 'Target'
FROM bude_cdb.letters
WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id NOT LIKE 'unknown%'
