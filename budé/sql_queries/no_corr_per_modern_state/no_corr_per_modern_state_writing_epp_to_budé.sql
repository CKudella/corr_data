SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(DISTINCT sender_id) AS 'Number of correspondents who wrote letters to Budé'
FROM budé_cdb_v1.letters,
     budé_cdb_v1.locations
WHERE locations.locations_id = letters.source_loc_id
  AND sender_id NOT LIKE 'budé_guillaume_viaf_105878228'
GROUP BY locations_modern_state
ORDER BY COUNT(DISTINCT sender_id) DESC
