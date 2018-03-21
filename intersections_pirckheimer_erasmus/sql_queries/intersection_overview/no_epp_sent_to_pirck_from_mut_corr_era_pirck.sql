SELECT COUNT(*) AS 'Total number of letters sent to Pirckheimer from mutual correspondents of his and and Erasmus'
FROM
  (SELECT *
   FROM wpirck_cdb_v1.letters) AS L
WHERE L.recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND L.sender_id IN
    (SELECT X.correspondents_id
     FROM wpirck_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               wpirck_cdb_v1.correspondents AS P
          WHERE E.correspondents_id = B.correspondents_id
            AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
            AND P.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'))
