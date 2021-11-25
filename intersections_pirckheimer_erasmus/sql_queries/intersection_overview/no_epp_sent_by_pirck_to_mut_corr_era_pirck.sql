SELECT COUNT(*) AS 'Total number of letters sent from Pirckheimer to mutual correspondents of his and and Erasmus'
FROM
  (SELECT *
   FROM wpirck_cdb_v1.letters) AS L
WHERE L.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND L.recipient_id IN
    (SELECT X.correspondents_id
     FROM wpirck_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               wpirck_cdb_v1.correspondents AS P
          WHERE E.correspondents_id = P.correspondents_id
            AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
            AND P.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
