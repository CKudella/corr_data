SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Erasmus sent to this modern state'
FROM letters,
     locations
WHERE locations.locations_id = letters.target_loc_id
  AND letters_id NOT LIKE '%ck2'
  AND sender_id = 'erasmus_desiderius_viaf_95982394'
GROUP BY locations_modern_state
ORDER BY COUNT(*) DESC
