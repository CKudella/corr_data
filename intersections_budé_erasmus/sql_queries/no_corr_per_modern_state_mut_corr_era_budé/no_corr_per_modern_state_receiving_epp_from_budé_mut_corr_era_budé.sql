SELECT DISTINCT locations.locations_modern_state AS 'Modern State',
                COUNT(DISTINCT recipient_id) AS 'Number of mutual correspondents of Erasmus and Budé who received letters from Budé in this modern state'
FROM budé_cdb_v1.letters,
     budé_cdb_v1.locations
WHERE locations.locations_id = letters.target_loc_id
  AND sender_id LIKE 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND recipient_id IN
    (SELECT E.correspondents_id
     FROM budé_cdb_v1.correspondents AS B,
          era_cdb_v3.correspondents AS E
     WHERE B.correspondents_id = E.correspondents_id
       AND B.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
       AND E.correspondents_id NOT IN ('be1dcbc4-3987-472a-b4a0-c3305ead139f',
                                       '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf',
                                       'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'))
GROUP BY locations_modern_state
ORDER BY COUNT(DISTINCT recipient_id) DESC
