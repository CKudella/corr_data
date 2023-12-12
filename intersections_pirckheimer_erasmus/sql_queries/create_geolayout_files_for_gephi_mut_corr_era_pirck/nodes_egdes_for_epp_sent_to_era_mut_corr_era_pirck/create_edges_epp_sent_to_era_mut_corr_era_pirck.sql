SELECT ELET.source_loc_id AS 'Source',
       ELET.target_loc_id AS 'Target'
FROM era_cdb_v3.letters AS ELET
WHERE ELET.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND ELET.sender_id IN
    (SELECT X.correspondents_id
     FROM wpirck_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               wpirck_cdb_v1.correspondents AS P
          WHERE E.correspondents_id = P.correspondents_id))
  AND ELET.source_loc_id NOT LIKE 'unknown%'
  AND ELET.target_loc_id NOT LIKE 'unknown%'
