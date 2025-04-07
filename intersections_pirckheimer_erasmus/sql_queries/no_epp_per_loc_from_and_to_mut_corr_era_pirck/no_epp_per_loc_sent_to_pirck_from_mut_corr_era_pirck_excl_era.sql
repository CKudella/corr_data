SELECT locations.locations_name_modern AS 'Location Name Modern',
       locations.locations_lat AS 'Latitude',
       locations.locations_lng AS 'Longitude',
       COUNT(letters.source_loc_id) AS 'Number of letters sent from this location to Pirckheimer from mutual correspondents of his and Erasmus (excl. Erasmus)'
FROM wpirck_cdb.letters
JOIN wpirck_cdb.locations ON locations.locations_id = letters.source_loc_id
WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND target_loc_id NOT LIKE 'unknown%'
  AND sender_id IN
    (SELECT X.correspondents_id
     FROM era_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT P.correspondents_id
          FROM wpirck_cdb.correspondents AS P,
               era_cdb.correspondents AS E
          WHERE P.correspondents_id = E.correspondents_id ))
  AND sender_id != '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND source_loc_id NOT LIKE 'unknown%'
GROUP BY source_loc_id
ORDER BY COUNT(letters.source_loc_id) DESC
