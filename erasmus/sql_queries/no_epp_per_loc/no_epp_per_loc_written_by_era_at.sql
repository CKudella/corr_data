SELECT locations.locations_name_modern AS 'Location Name',
       COUNT(letters.source_loc_id) AS 'Number of letters sent from this location from Erasmus'
FROM era_cdb_v3.letters
JOIN locations ON locations.locations_id = letters.source_loc_id
WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND source_loc_id NOT LIKE 'unknown%'
GROUP BY source_loc_id
ORDER BY COUNT(letters.source_loc_id) DESC
