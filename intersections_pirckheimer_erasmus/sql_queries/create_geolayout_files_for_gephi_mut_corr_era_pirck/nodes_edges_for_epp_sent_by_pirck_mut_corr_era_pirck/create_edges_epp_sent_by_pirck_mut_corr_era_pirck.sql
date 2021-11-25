SELECT PLET.source_loc_id AS 'Source',
       PLET.target_loc_id AS 'Target'
FROM wpirck_cdb_v1.letters AS PLET
WHERE PLET.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND PLET.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
  AND PLET.recipient_id IN
    (SELECT X.correspondents_id
     FROM wpirck_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               wpirck_cdb_v1.correspondents AS P
          WHERE E.correspondents_id = P.correspondents_id))
  AND PLET.source_loc_id NOT LIKE 'unknown%'
  AND PLET.target_loc_id NOT LIKE 'unknown%'
