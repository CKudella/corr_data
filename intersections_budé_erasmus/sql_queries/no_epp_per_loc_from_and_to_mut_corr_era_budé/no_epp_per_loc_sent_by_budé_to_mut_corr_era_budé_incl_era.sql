SELECT locations.locations_name_modern AS 'Location Name Modern',
       locations.locations_lat AS 'Latitude',
       locations.locations_lng AS 'Longitude',
       COUNT(letters.target_loc_id) AS 'Number of letters sent to this location by Budé to mutual correspondents of his and Erasmus (incl. Erasmus)'
FROM budé_cdb_v1.letters
JOIN budé_cdb_v1.locations ON locations.locations_id = letters.target_loc_id
WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND source_loc_id NOT LIKE 'unknown%'
  AND recipient_id IN
    (SELECT X.correspondents_id
     FROM era_cdb_v3.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT B.correspondents_id
          FROM budé_cdb_v1.correspondents AS B,
               era_cdb_v3.correspondents AS E
          WHERE B.correspondents_id = E.correspondents_id))
  AND target_loc_id NOT LIKE 'unknown%'
GROUP BY target_loc_id
ORDER BY COUNT(letters.target_loc_id) DESC
