SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(DISTINCT recipient_id) AS 'Number of correspondents who received letters from Pirckheimer'
FROM letters,
     locations
WHERE locations.locations_id = letters.target_loc_id
  AND sender_id LIKE 'pirckheimer_willibald_viaf_27173507'
GROUP BY locations_modern_state
ORDER BY COUNT(DISTINCT recipient_id) DESC
