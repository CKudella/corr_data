SELECT locations.locations_name_modern
FROM era_cdb.locations
WHERE locations.locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM era_cdb.letters
     WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
  AND locations.locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM era_cdb.letters
     WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
