SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(DISTINCT recipient_id) AS 'Number of correspondents who received letters from Pirckheimer'
FROM wpirck_cdb_v1.letters,
     locations
WHERE locations.locations_id = letters.target_loc_id
  AND sender_id LIKE 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY locations_modern_state
ORDER BY COUNT(DISTINCT recipient_id) DESC
