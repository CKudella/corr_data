SELECT DISTINCT locations.locations_modern_state AS 'Name Modern State',
                COUNT(letters.source_loc_id) AS 'Number of letters sent from this modern state to Budé from mutual correspondents of his and Erasmus (excl. Erasmus)'
FROM bude_cdb.letters
JOIN bude_cdb.locations ON locations.locations_id = letters.source_loc_id
WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND sender_id IN
    (SELECT X.correspondents_id
     FROM era_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT B.correspondents_id
          FROM bude_cdb.correspondents AS B,
               era_cdb.correspondents AS E
          WHERE B.correspondents_id = E.correspondents_id))
  AND sender_id != '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY locations_modern_state
ORDER BY COUNT(letters.source_loc_id) DESC
