SELECT locations_id AS 'Id',
       locations_name_modern,
       locations_lat,
       locations_lng,
       locations_ll_combined
FROM locations
WHERE locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM letters
     WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND source_loc_id NOT LIKE 'unknown%'
       AND target_loc_id LIKE 'venice%')
  OR locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM letters
     WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND target_loc_id LIKE 'venice%')
GROUP BY locations_id
