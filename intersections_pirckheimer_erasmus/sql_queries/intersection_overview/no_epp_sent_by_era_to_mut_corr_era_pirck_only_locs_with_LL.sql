SELECT COUNT(*) AS 'Total number of letters sent by Erasmus to mutual correspondents of his and and Pirckheimer (only letters with source and target locations with geocoordinates)'
FROM
  (SELECT *
   FROM era_cdb.letters) AS L
WHERE L.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND L.source_loc_id NOT LIKE 'unknown%'
  AND L.recipient_id IN
    (SELECT X.correspondents_id
     FROM wpirck_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb.correspondents AS E,
               wpirck_cdb.correspondents AS P
          WHERE E.correspondents_id = P.correspondents_id
            AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
            AND P.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
  AND L.target_loc_id NOT LIKE 'unknown%'
