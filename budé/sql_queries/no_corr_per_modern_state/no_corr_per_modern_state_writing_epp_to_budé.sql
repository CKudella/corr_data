SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(DISTINCT sender_id) AS 'Number of correspondents who wrote letters to Budé'
FROM bude_cdb.letters,
     bude_cdb.locations
WHERE locations.locations_id = letters.source_loc_id
  AND sender_id NOT LIKE 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
GROUP BY locations_modern_state
ORDER BY COUNT(DISTINCT sender_id) DESC
