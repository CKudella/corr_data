SELECT COUNT(*) AS 'Total number of letters exchanged between Erasmus and mutual correspondents of his and and Pirckheimer (only letters with source and target locs with geocoordinate)'
FROM
  (SELECT *
   FROM era_cdb.letters) AS L
WHERE L.sender_id IN
    (SELECT X.correspondents_id
     FROM era_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT P.correspondents_id
          FROM wpirck_cdb.correspondents AS P,
               era_cdb.correspondents AS E
          WHERE P.correspondents_id = E.correspondents_id
            AND P.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
            AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
  AND L.source_loc_id NOT LIKE 'unknown%'
  AND L.recipient_id IN
    (SELECT X.correspondents_id
     FROM era_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT P.correspondents_id
          FROM wpirck_cdb.correspondents AS P,
               era_cdb.correspondents AS E
          WHERE P.correspondents_id = E.correspondents_id
            AND P.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
            AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'))
  AND L.target_loc_id NOT LIKE 'unknown%'
