SELECT DISTINCT locations.locations_modern_state AS 'Name Modern State',
                COUNT(letters.target_loc_id) AS 'Number of letters sent to this modern state by Pirckheimer to mutual correspondents of his and Erasmus (excl. Erasmus)'
FROM wpirck_cdb.letters
JOIN wpirck_cdb.locations ON locations.locations_id = letters.target_loc_id
WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND recipient_id IN
    (SELECT X.correspondents_id
     FROM era_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT P.correspondents_id
          FROM wpirck_cdb.correspondents AS P,
               era_cdb.correspondents AS E
          WHERE P.correspondents_id = E.correspondents_id ))
  AND recipient_id != '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY locations_modern_state
ORDER BY COUNT(letters.target_loc_id) DESC
