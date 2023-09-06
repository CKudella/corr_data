SELECT COUNT(locations.locations_name_modern) AS 'Total Number of locations where Erasmus sent letters from but from which he did not receive any'
FROM era_cdb_v3.locations
WHERE locations.locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM era_cdb_v3.letters
     WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
  AND locations.locations_id NOT IN
    (SELECT DISTINCT source_loc_id
     FROM era_cdb_v3.letters
     WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
