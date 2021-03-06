SELECT ELET.source_loc_id AS 'Source',
       ELET.target_loc_id AS 'Target'
FROM era_cdb_v3.letters AS ELET
WHERE ELET.sender_id = 'erasmus_desiderius_viaf_95982394'
  AND ELET.letters_id NOT LIKE '%ck2'
  AND ELET.recipient_id IN
    (SELECT X.correspondents_id
     FROM wpirck_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               wpirck_cdb_v1.correspondents AS P
          WHERE E.correspondents_id = P.correspondents_id))
  AND ELET.source_loc_id NOT LIKE 'unknown%'
  AND ELET.target_loc_id NOT LIKE 'unknown%'
