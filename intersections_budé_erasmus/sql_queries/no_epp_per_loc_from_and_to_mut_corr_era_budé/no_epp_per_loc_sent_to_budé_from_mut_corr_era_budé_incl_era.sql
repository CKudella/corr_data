SELECT locations.locations_name_modern AS 'Location Name Modern',
       locations.locations_lat AS 'Latitude',
       locations.locations_lng AS 'Longitude',
       COUNT(letters.source_loc_id) AS 'Number of letters sent from this location to Budé from mutual correspondents of his and Erasmus (incl. Erasmus)'
FROM budé_cdb_v1.letters
JOIN budé_cdb_v1.locations ON locations.locations_id = letters.source_loc_id
WHERE letters_id NOT LIKE '%ck2'
  AND recipient_id = 'budé_guillaume_viaf_105878228'
  AND sender_id IN
    (SELECT X.correspondents_id
     FROM era_cdb_v3.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT B.correspondents_id
          FROM budé_cdb_v1.correspondents AS B,
               era_cdb_v3.correspondents AS E
          WHERE B.correspondents_id = E.correspondents_id
            AND B.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
            AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
))
GROUP BY source_loc_id
ORDER BY COUNT(letters.source_loc_id) DESC
