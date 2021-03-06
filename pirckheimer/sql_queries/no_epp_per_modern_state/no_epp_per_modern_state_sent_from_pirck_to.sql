SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Pirckheimer sent to this modern state'
FROM letters,
     locations
WHERE locations.locations_id = letters.target_loc_id
  AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
  AND sender_id = 'pirckheimer_willibald_viaf_27173507'
GROUP BY locations_modern_state
ORDER BY COUNT(*) DESC
