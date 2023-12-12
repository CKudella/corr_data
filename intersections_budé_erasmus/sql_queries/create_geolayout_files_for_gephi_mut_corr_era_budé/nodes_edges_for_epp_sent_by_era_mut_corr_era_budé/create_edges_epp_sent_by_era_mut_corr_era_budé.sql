SELECT ELET.source_loc_id AS 'Source',
       ELET.target_loc_id AS 'Target'
FROM era_cdb_v3.letters AS ELET
WHERE ELET.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND ELET.recipient_id IN
    (SELECT X.correspondents_id
     FROM budé_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               budé_cdb_v1.correspondents AS B
          WHERE E.correspondents_id = B.correspondents_id))
  AND ELET.source_loc_id NOT LIKE 'unknown%'
  AND ELET.target_loc_id NOT LIKE 'unknown%'
