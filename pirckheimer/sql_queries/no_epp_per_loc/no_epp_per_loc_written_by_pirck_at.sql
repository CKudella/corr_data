SELECT locations.locations_name_modern AS 'Location Name',
       COUNT(letters.source_loc_id) AS 'Number of letters sent from this location by Pirckheimer'
FROM wpirck_cdb.letters
JOIN locations ON locations.locations_id = letters.source_loc_id
WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND source_loc_id NOT LIKE 'unknown%'
GROUP BY source_loc_id
ORDER BY COUNT(letters.source_loc_id) DESC
