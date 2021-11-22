SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(DISTINCT sender_id) AS 'Number of correspondents who wrote letters to Erasmus'
FROM letters,
     locations
WHERE locations.locations_id = letters.source_loc_id
  AND recipient_id LIKE '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY locations_modern_state
ORDER BY COUNT(DISTINCT sender_id) DESC
