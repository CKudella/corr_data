SELECT locations.locations_name_modern AS 'Location Name',
       COUNT(letters.source_loc_id) AS 'Number of letters sent from this location'
FROM bude_cdb.letters
JOIN bude_cdb.locations ON locations.locations_id = letters.source_loc_id
WHERE source_loc_id NOT LIKE 'unknown%'
GROUP BY source_loc_id
ORDER BY COUNT(letters.source_loc_id) DESC
