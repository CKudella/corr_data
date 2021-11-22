SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(*) AS 'Number of letters written at this modern state by Erasmus'
FROM letters,
     locations
WHERE locations.locations_id = letters.source_loc_id
  AND letters_id NOT LIKE '%ck2'
  AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY locations_modern_state
ORDER BY COUNT(*) DESC
