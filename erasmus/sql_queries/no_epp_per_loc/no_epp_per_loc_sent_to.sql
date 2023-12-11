SELECT locations.locations_name_modern AS 'Location Name',
       COUNT(letters.source_loc_id) AS 'Number of letters sent to this location'
FROM era_cdb_v3.letters
JOIN locations ON locations.locations_id = letters.target_loc_id
WHERE target_loc_id NOT LIKE 'unknown%'
GROUP BY target_loc_id
ORDER BY COUNT(letters.target_loc_id) DESC
