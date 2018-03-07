SELECT locations_name_modern AS 'Location Name Modern',
       locations_lat AS Latitude,
       locations_lng AS Longitude,
       COUNT(DISTINCT recipient_id) AS 'Number of correspondents who received at this Location letters from Erasmus'
FROM letters
JOIN era_cdb_v3.locations ON locations.locations_id = letters.target_loc_id
WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
GROUP BY target_loc_id
ORDER BY COUNT(DISTINCT recipient_id) DESC
