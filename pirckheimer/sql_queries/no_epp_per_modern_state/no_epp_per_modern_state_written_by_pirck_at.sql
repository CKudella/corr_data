SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters written at this modern state by Pirckheimer'
FROM wpirck_cdb.letters,
     locations
WHERE locations.locations_id = letters.source_loc_id
  AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY locations_modern_state
ORDER BY COUNT(*) DESC
