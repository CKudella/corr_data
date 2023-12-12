SELECT locations.locations_name_modern AS 'Location Name Modern',
       locations.locations_lat AS 'Latitude',
       locations.locations_lng AS 'Longitude',
       COUNT(letters.source_loc_id) AS 'Number of letters sent from this location to Budé from mutual correspondents of his and Erasmus (excl. Erasmus)'
FROM budé_cdb_v1.letters
JOIN budé_cdb_v1.locations ON locations.locations_id = letters.source_loc_id
WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND target_loc_id NOT LIKE 'unknown%'
  AND sender_id IN
    (SELECT X.correspondents_id
     FROM era_cdb_v3.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT B.correspondents_id
          FROM budé_cdb_v1.correspondents AS B,
               era_cdb_v3.correspondents AS E
          WHERE B.correspondents_id = E.correspondents_id ))
  AND sender_id != '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND source_loc_id NOT LIKE 'unknown%'
GROUP BY source_loc_id
ORDER BY COUNT(letters.source_loc_id) DESC
