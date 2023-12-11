SELECT locations.locations_name_modern AS 'Location Name',
       locations.locations_lat AS 'Latitude',
       locations.locations_lng AS 'Longitude',
       COUNT(letters.target_loc_id) AS 'Number of Letters sent to this location from Pirckheimer'
FROM wpirck_cdb_v1.letters
JOIN locations ON locations.locations_id = letters.target_loc_id
WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND target_loc_id NOT LIKE 'unknown%'
GROUP BY target_loc_id
ORDER BY COUNT(letters.target_loc_id) DESC
