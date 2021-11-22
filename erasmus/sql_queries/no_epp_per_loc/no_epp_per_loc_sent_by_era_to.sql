SELECT locations.locations_name_modern AS 'Location Name',
       COUNT(letters.target_loc_id) AS 'Number of letters sent to this location from Erasmus'
FROM letters
JOIN locations ON locations.locations_id = letters.target_loc_id
WHERE letters_id NOT LIKE '%ck2'
  AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND target_loc_id NOT LIKE 'unknown%'
GROUP BY target_loc_id
ORDER BY COUNT(letters.target_loc_id) DESC
