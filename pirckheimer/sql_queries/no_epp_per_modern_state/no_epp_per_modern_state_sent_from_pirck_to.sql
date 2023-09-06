SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters Pirckheimer sent to this modern state'
FROM wpirck_cdb_v1.letters,
     locations
WHERE locations.locations_id = letters.target_loc_id
  AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
  AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY locations_modern_state
ORDER BY COUNT(*) DESC
