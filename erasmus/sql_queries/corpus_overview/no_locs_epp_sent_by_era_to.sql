SELECT COUNT(locations.locations_id) AS 'Total number of locations Erasmus has sent letters to'
FROM era_cdb_v3.locations
WHERE locations.locations_id IN
    (SELECT DISTINCT target_loc_id
     FROM era_cdb_v3.letters
     WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND target_loc_id NOT LIKE 'unknown%'
     GROUP BY target_loc_id)
