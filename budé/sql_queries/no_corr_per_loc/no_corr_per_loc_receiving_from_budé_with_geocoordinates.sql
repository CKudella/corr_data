SELECT locations_name_modern AS 'Location Name Modern',
       locations_lat AS Latitude,
       locations_lng AS Longitude,
       COUNT(DISTINCT recipient_id) AS 'Number of correspondents who received at this location letters from Budé'
FROM letters
JOIN budé_cdb_v1.locations ON locations.locations_id = letters.target_loc_id
WHERE sender_id = 'budé_guillaume_viaf_105878228'
GROUP BY target_loc_id
ORDER BY COUNT(DISTINCT recipient_id) DESC
