SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(DISTINCT sender_id) AS 'Number of correspondents who wrote letters to Pirckheimer'
FROM letters,
     locations
WHERE locations.locations_id = letters.source_loc_id
  AND recipient_id LIKE 'pirckheimer_willibald_viaf_27173507'
GROUP BY locations_modern_state
ORDER BY COUNT(DISTINCT sender_id) DESC
