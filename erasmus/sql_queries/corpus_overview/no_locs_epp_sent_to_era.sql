SELECT COUNT(locations.locations_id) AS 'Total number of locations from which letters were sent to Erasmus'
FROM era_cdb_v3.locations
WHERE locations.locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM era_cdb_v3.letters
     WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
