SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters sent from this modern state'
FROM era_cdb_v3.letters,
     locations
WHERE locations.locations_id = letters.source_loc_id
  AND letters_id NOT LIKE '%ck2'
GROUP BY locations_modern_state
ORDER BY COUNT(*) DESC
