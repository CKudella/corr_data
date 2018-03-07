SELECT COUNT(locations.locations_id) AS 'Number of locations to which letters have been sent by Budé'
FROM locations
WHERE locations.locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228'
       AND target_loc_id NOT LIKE 'unknown%'
     GROUP BY target_loc_id)
