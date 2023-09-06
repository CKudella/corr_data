SELECT locations_id AS 'Id',
       locations_name_modern AS 'Label',
       locations_modern_state,
       locations_modern_province,
       locations_lat,
       locations_lng
FROM wpirck_cdb_v1.locations
WHERE locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM wpirck_cdb_v1.letters
     WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
       AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
       AND source_loc_id NOT LIKE 'unknown%'
       AND target_loc_id NOT LIKE 'unknown%')
  OR locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM wpirck_cdb_v1.letters
     WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
       AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
       AND source_loc_id NOT LIKE 'unknown%'
       AND target_loc_id NOT LIKE 'unknown%')
GROUP BY locations_id
