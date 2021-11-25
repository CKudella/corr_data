SELECT COUNT(*) AS 'Total number of letters sent to Erasmus from mutual correspondents of his and and Pirckheimer'
FROM
  (SELECT *
   FROM era_cdb_v3.letters) AS L
WHERE L.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND L.sender_id IN
    (SELECT X.correspondents_id
     FROM wpirck_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               wpirck_cdb_v1.correspondents AS P
          WHERE E.correspondents_id = P.correspondents_id
            AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
            AND P.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
