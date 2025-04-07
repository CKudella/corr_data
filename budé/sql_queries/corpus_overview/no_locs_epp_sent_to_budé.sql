SELECT COUNT(locations.locations_id) AS 'Number of locations from which letters have been sent to Budé'
FROM bude_cdb.locations
WHERE locations.locations_id IN
    (SELECT DISTINCT source_loc_id
     FROM bude_cdb.letters
     WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
       AND source_loc_id NOT LIKE 'unknown%'
     GROUP BY source_loc_id)
