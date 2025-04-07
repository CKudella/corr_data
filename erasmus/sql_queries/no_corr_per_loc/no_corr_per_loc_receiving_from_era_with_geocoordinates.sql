SELECT locations_name_modern AS 'Location Name Modern',
       locations_lat AS Latitude,
       locations_lng AS Longitude,
       COUNT(DISTINCT recipient_id) AS 'Number of correspondents who received at this location letters from Erasmus'
FROM era_cdb.letters
JOIN era_cdb.locations ON locations.locations_id = letters.target_loc_id
WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND target_loc_id NOT LIKE 'unknown%'
GROUP BY target_loc_id
ORDER BY COUNT(DISTINCT recipient_id) DESC
