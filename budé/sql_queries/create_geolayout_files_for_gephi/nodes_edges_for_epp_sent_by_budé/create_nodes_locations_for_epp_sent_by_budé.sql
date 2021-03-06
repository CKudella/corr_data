SELECT locations_id AS 'Id',
       locations_name_modern AS 'Label',
       locations_modern_state,
       locations_modern_province,
       locations_lat,
       locations_lng
FROM locations
WHERE locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND letters_id NOT LIKE '%ck2'
       AND source_loc_id NOT LIKE 'unknown%'
       AND target_loc_id NOT LIKE 'unknown%')
  OR locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND letters_id NOT LIKE '%ck2'
       AND source_loc_id NOT LIKE 'unknown%'
       AND target_loc_id NOT LIKE 'unknown%')
GROUP BY locations_id
