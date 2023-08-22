SELECT locations.locations_name_modern AS 'Location Name Modern',
       locations.locations_lat AS 'Latitude',
       locations.locations_lng AS 'Longitude',
       COUNT(letters.target_loc_id) AS 'Number of letters sent to this location by Pirckheimer to mutual correspondents of his and Erasmus (incl. Erasmus)'
FROM wpirck_cdb_v1.letters
JOIN wpirck_cdb_v1.locations ON locations.locations_id = letters.target_loc_id
WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
  AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND recipient_id IN
    (SELECT X.correspondents_id
     FROM era_cdb_v3.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT P.correspondents_id
          FROM wpirck_cdb_v1.correspondents AS P,
               era_cdb_v3.correspondents AS E
          WHERE P.correspondents_id = E.correspondents_id))
  AND target_loc_id NOT LIKE 'unknown%'
GROUP BY target_loc_id
ORDER BY COUNT(letters.target_loc_id) DESC
