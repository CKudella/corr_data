SELECT *
FROM
  (SELECT *
   FROM era_cdb_v3.letters
   UNION ALL
     (SELECT *
      FROM wpirck_cdb_v1.letters
      WHERE letters_id NOT LIKE '%_cwe_%')) AS L
WHERE L.sender_id IN
    (SELECT X.correspondents_id
     FROM era_cdb_v3.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT P.correspondents_id
          FROM wpirck_cdb_v1.correspondents AS P,
               era_cdb_v3.correspondents AS E
          WHERE P.correspondents_id = E.correspondents_id
            AND P.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
            AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'))
  AND L. recipient_id IN
    (SELECT X.correspondents_id
     FROM era_cdb_v3.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT P.correspondents_id
          FROM wpirck_cdb_v1.correspondents AS P,
               era_cdb_v3.correspondents AS E
          WHERE P.correspondents_id = E.correspondents_id
            AND P.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
            AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'))
