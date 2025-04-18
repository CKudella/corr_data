SELECT locations_id AS 'Id',
       locations_name_modern AS 'Label',
       locations_modern_state,
       locations_modern_province,
       locations_lat,
       locations_lng
FROM bude_cdb.locations
WHERE locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM bude_cdb.letters
     WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
       AND source_loc_id NOT LIKE 'unknown%'
       AND target_loc_id NOT LIKE 'unknown%')
  OR locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM bude_cdb.letters
     WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
       AND source_loc_id NOT LIKE 'unknown%'
       AND target_loc_id NOT LIKE 'unknown%')
GROUP BY locations_id, locations_name_modern, locations_modern_state, 
         locations_modern_province, locations_lat, locations_lng
