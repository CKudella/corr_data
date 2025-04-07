SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters sent to this modern state'
FROM bude_cdb.letters,
     bude_cdb.locations
WHERE locations.locations_id = letters.target_loc_id
GROUP BY locations_modern_state
ORDER BY COUNT(*) DESC
