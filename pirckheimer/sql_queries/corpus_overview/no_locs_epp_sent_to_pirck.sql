SELECT COUNT(locations.locations_name_modern) AS 'Number of locations from which letters have been sent to Pirckheimer'
FROM wpirck_cdb.locations
WHERE locations.locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM wpirck_cdb.letters
     WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
