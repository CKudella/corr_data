SELECT locations.locations_name_modern AS 'Location Name',
       COUNT(letters.target_loc_id) AS 'Number of letters sent to this location from Budé'
FROM bude_cdb.letters
JOIN bude_cdb.locations ON locations.locations_id = letters.target_loc_id
WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND target_loc_id NOT LIKE 'unknown%'
GROUP BY target_loc_id
ORDER BY COUNT(letters.target_loc_id) DESC
