SELECT COUNT(locations.locations_id) AS 'Number of locations to which letters have been sent by Budé'
FROM bude_cdb_v1.locations
WHERE locations.locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM bude_cdb_v1.letters
     WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
       AND target_loc_id NOT LIKE 'unknown%'
     GROUP BY target_loc_id)
