SELECT locations_id AS 'Id',
       locations_name_modern,
       locations_lat,
       locations_lng,
       locations_ll_combined
FROM locations
WHERE locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM letters
     WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
       AND source_loc_id NOT LIKE 'unknown%'
       AND recipient_id = 'nausea_friedrich_viaf_248203874')
  OR locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM letters
     WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
       AND recipient_id = 'nausea_friedrich_viaf_248203874')
GROUP BY locations_id
