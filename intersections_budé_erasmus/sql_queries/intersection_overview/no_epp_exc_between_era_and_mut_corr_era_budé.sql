SELECT COUNT(*) AS 'Total number of letters exchanged between Erasmus and mutual correspondents of his and and Budé'
FROM
  (SELECT *
   FROM era_cdb_v3.letters) AS L
WHERE L.sender_id IN
    (SELECT X.correspondents_id
     FROM era_cdb_v3.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT B.correspondents_id
          FROM budé_cdb_v1.correspondents AS B,
               era_cdb_v3.correspondents AS E
          WHERE B.correspondents_id = E.correspondents_id
            AND B.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
            AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'))
  AND L.recipient_id IN
    (SELECT X.correspondents_id
     FROM era_cdb_v3.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT B.correspondents_id
          FROM budé_cdb_v1.correspondents AS B,
               era_cdb_v3.correspondents AS E
          WHERE B.correspondents_id = E.correspondents_id
            AND B.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
            AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'))
