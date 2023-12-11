SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters sent this this modern state'
FROM era_cdb_v3.letters,
     locations
WHERE locations.locations_id = letters.target_loc_id
GROUP BY locations_modern_state
ORDER BY COUNT(*) DESC
