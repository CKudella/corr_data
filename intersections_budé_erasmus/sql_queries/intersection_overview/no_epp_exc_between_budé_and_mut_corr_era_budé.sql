SELECT COUNT(*) AS 'Total number of letters exchanged between Budé and mutual correspondents of his and and Erasmus'
FROM
  (SELECT *
   FROM bude_cdb_v1.letters) AS L
WHERE L.sender_id IN
    (SELECT X.correspondents_id
     FROM bude_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               bude_cdb_v1.correspondents AS B
          WHERE E.correspondents_id = B.correspondents_id
            AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
            AND B.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
  AND L.recipient_id IN
    (SELECT X.correspondents_id
     FROM bude_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               bude_cdb_v1.correspondents AS B
          WHERE E.correspondents_id = B.correspondents_id
            AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
            AND B.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
