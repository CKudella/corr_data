SELECT locations_id AS 'Id',
       locations_name_modern,
       locations_modern_state,
       locations_modern_province,
       locations_lat,
       locations_lng
FROM locations
WHERE locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM letters
     WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
       AND source_loc_id NOT LIKE 'unknown%')
  OR locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM letters
     WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
       AND target_loc_id NOT LIKE 'unknown%')
GROUP BY locations_id
