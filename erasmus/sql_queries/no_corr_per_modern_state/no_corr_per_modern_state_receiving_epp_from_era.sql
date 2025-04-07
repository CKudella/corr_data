SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(DISTINCT recipient_id) AS 'Number of correspondents who received letters from Erasmus'
FROM era_cdb.letters,
     locations
WHERE locations.locations_id = letters.target_loc_id
  AND sender_id LIKE '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY locations_modern_state
ORDER BY COUNT(DISTINCT recipient_id) DESC
