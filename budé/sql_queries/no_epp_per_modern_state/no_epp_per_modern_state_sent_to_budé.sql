SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of Letters sent from this modern state to Budé'
FROM letters,
     locations
WHERE locations.locations_id = letters.source_loc_id
  AND letters_id NOT LIKE '%ck2'
  AND recipient_id = 'budé_guillaume_viaf_105878228'
GROUP BY locations_modern_state
ORDER BY COUNT(*) DESC
