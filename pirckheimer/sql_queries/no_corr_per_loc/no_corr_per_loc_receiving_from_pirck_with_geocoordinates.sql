SELECT locations_name_modern AS 'Location Name Modern',
       locations_lat AS Latitude,
       locations_lng AS Longitude,
       COUNT(DISTINCT recipient_id) AS 'Number of correspondents who received at this Location letters from Pirckheimer'
FROM wpirck_cdb.letters
JOIN wpirck_cdb.locations ON locations.locations_id = letters.target_loc_id
WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND target_loc_id NOT LIKE 'unknown%'
GROUP BY target_loc_id
ORDER BY COUNT(DISTINCT recipient_id) DESC
