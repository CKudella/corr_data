SELECT locations_name_modern AS 'Location Name Modern',
       locations_lat AS Latitude,
       locations_lng AS Longitude,
       COUNT(DISTINCT sender_id) AS 'Number of correspondents who wrote from this location letters to Erasmus'
FROM letters
JOIN era_cdb_v3.locations ON locations.locations_id = letters.source_loc_id
WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND source_loc_id NOT LIKE 'unknown%'
GROUP BY source_loc_id
ORDER BY COUNT(DISTINCT sender_id) DESC
