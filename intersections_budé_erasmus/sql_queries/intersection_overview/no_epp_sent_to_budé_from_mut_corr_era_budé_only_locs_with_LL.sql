SELECT COUNT(*) AS 'Total number of letters sent to Budé from mutual correspondents of his and and Erasmus (only letters with source and target locations with geocoordinates)'
FROM
  (SELECT *
   FROM budé_cdb_v1.letters) AS L
WHERE L.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND L.source_loc_id NOT LIKE 'unknown%'
  AND L.sender_id IN
    (SELECT X.correspondents_id
     FROM budé_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               budé_cdb_v1.correspondents AS B
          WHERE E.correspondents_id = B.correspondents_id
            AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
            AND B.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
  AND L.target_loc_id NOT LIKE 'unknown%'
