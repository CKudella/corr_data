SELECT DISTINCT locations.locations_modern_state AS 'Name Modern State',
                COUNT(letters.target_loc_id) AS 'Number of letters sent to this modern state by Erasmus to mutual correspondents of his and Budé (incl. Budé)'
FROM era_cdb.letters
JOIN era_cdb.locations ON locations.locations_id = letters.target_loc_id
WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND recipient_id IN
    (SELECT X.correspondents_id
     FROM era_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT B.correspondents_id
          FROM bude_cdb.correspondents AS B,
               era_cdb.correspondents AS E
          WHERE B.correspondents_id = E.correspondents_id))
GROUP BY locations_modern_state
ORDER BY COUNT(letters.target_loc_id) DESC
