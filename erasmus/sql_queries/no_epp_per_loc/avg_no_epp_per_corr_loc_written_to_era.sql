SELECT Y.locations_name_modern AS 'Location Name',
       X.locations_lat AS 'Latitude',
       X.locations_lng AS 'Longitude',
       X.count AS 'Number of correspondents writing to Erasmus',
       Y.count AS 'Number of letters written to Erasmus',
       Y.COUNT/X.COUNT AS 'Average Number of Letters'
FROM
  (SELECT locations_name_modern,
          locations_lat,
          locations_lng,
          COUNT(DISTINCT sender_id) AS COUNT
   FROM letters
   JOIN era_cdb_v3.locations ON locations.locations_id = letters.source_loc_id
   WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.target_loc_id) AS COUNT
   FROM letters
   JOIN locations ON locations.locations_id = letters.source_loc_id
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
