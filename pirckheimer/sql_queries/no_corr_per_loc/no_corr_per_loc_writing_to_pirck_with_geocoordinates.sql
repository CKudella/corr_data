SELECT locations_name_modern AS 'Location Name Modern',
       locations_lat AS Latitude,
       locations_lng AS Longitude,
       COUNT(DISTINCT sender_id) AS 'Number of correspondents who wrote from this location letters to Pirckheimer'
FROM letters
JOIN locations ON locations.locations_id = letters.source_loc_id
WHERE sender_id != 'd9233b24-a98c-4279-8065-e2ab70c0d080'
AND source_loc_id NOT LIKE 'unknown%'
GROUP BY source_loc_id
ORDER BY COUNT(DISTINCT sender_id) DESC
