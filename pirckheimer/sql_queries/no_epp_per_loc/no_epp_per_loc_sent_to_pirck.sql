SELECT locations.locations_name_modern AS 'Location Name',
       COUNT(letters.source_loc_id) AS 'Number of letters sent from this location to Pirckheimer'
FROM letters
JOIN locations ON locations.locations_id = letters.source_loc_id
WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
  AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND source_loc_id NOT LIKE 'unknown%'
GROUP BY source_loc_id
ORDER BY COUNT(letters.source_loc_id) DESC
