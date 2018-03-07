SELECT COUNT(locations.locations_id) AS 'Number of locations to which letters have been sent by Pirckheimer'
FROM locations
WHERE locations.locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM letters
     WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
       AND target_loc_id NOT LIKE 'unknown%'
     GROUP BY target_loc_id)
