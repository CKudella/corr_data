SELECT COUNT(locations.locations_id) AS 'Total number of locations from which letters were sent to Erasmus'
FROM era_cdb_v3.locations
WHERE locations.locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM letters
     WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
