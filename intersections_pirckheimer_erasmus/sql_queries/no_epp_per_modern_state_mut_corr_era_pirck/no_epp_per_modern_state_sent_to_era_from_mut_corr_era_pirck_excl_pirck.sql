SELECT DISTINCT locations.locations_modern_state AS 'Name Modern State',
                COUNT(letters.source_loc_id) AS 'Number of letters sent from this modern state to Erasmus from mutual correspondents of his and Pirckheimer (excl. Pirckheimer)'
FROM era_cdb.letters
JOIN era_cdb.locations ON locations.locations_id = letters.source_loc_id
WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND sender_id IN
    (SELECT X.correspondents_id
     FROM era_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT P.correspondents_id
          FROM wpirck_cdb.correspondents AS P,
               era_cdb.correspondents AS E
          WHERE P.correspondents_id = E.correspondents_id))
  AND sender_id != 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY locations_modern_state
ORDER BY COUNT(letters.source_loc_id) DESC
