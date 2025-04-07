SELECT PLET.source_loc_id AS 'Source',
       PLET.target_loc_id AS 'Target'
FROM wpirck_cdb.letters AS PLET
WHERE PLET.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND PLET.sender_id IN
    (SELECT X.correspondents_id
     FROM wpirck_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb.correspondents AS E,
               wpirck_cdb.correspondents AS P
          WHERE E.correspondents_id = P.correspondents_id))
  AND PLET.source_loc_id NOT LIKE 'unknown%'
  AND PLET.target_loc_id NOT LIKE 'unknown%'
