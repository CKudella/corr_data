SELECT locations_id AS 'Id',
       locations_name_modern AS 'Label',
       locations_modern_state,
       locations_modern_province,
       locations_lat,
       locations_lng
FROM wpirck_cdb.locations
WHERE locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM wpirck_cdb.letters
     WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
       AND source_loc_id NOT LIKE 'unknown%'
       AND target_loc_id NOT LIKE 'unknown%')
  OR locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM wpirck_cdb.letters
     WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
       AND source_loc_id NOT LIKE 'unknown%'
       AND target_loc_id NOT LIKE 'unknown%')
GROUP BY locations_id, locations_name_modern, locations_modern_state, 
         locations_modern_province, locations_lat, locations_lng
