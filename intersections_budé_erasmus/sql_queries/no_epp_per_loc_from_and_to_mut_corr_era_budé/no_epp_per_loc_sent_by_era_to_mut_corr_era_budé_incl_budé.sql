SELECT locations.locations_name_modern AS 'Location Name Modern',
       locations.locations_lat AS 'Latitude',
       locations.locations_lng AS 'Longitude',
       COUNT(letters.target_loc_id) AS 'Number of letters sent to this location by Erasmus to mutual correspondents of his and Budé (incl. Budé)'
FROM era_cdb.letters
JOIN era_cdb.locations ON locations.locations_id = letters.target_loc_id
WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND source_loc_id NOT LIKE 'unknown%'
  AND recipient_id IN
    (SELECT X.correspondents_id
     FROM era_cdb.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT B.correspondents_id
          FROM bude_cdb.correspondents AS B,
               era_cdb.correspondents AS E
          WHERE B.correspondents_id = E.correspondents_id))
  AND target_loc_id NOT LIKE 'unknown%'
GROUP BY target_loc_id
ORDER BY COUNT(letters.target_loc_id) DESC
