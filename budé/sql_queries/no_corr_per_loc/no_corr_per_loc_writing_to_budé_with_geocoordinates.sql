SELECT locations_name_modern AS 'Location Name Modern',
       locations_lat AS Latitude,
       locations_lng AS Longitude,
       COUNT(DISTINCT sender_id) AS 'Number of correspondents who wrote from this location letters to Budé'
FROM bude_cdb.letters
JOIN bude_cdb.locations ON locations.locations_id = letters.source_loc_id
WHERE sender_id != 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND source_loc_id NOT LIKE 'unknown%'
GROUP BY source_loc_id
ORDER BY COUNT(DISTINCT sender_id) DESC
