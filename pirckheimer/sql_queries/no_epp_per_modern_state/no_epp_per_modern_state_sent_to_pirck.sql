SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters sent from this modern state to Pirckheimer'
FROM letters,
     locations
WHERE locations.locations_id = letters.source_loc_id
  AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
  AND recipient_id = 'pirckheimer_willibald_viaf_27173507'
GROUP BY locations_modern_state
ORDER BY COUNT(*) DESC
