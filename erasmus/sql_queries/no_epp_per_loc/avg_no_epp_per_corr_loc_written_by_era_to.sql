SELECT Y.locations_name_modern AS 'Location Name',
       X.locations_lat AS 'Latitude',
       X.locations_lng AS 'Longitude',
       X.count AS 'Number of correspondents Erasmus writes to',
       Y.count AS 'Number of letters written by Erasmus',
       Y.COUNT/X.COUNT AS 'Average Number of letters per correspondent'
FROM
  (SELECT locations_name_modern,
          locations_lat,
          locations_lng,
          COUNT(DISTINCT recipient_id) AS COUNT
   FROM era_cdb_v3.letters
   JOIN era_cdb_v3.locations ON locations.locations_id = letters.target_loc_id
   WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND target_loc_id NOT LIKE 'unknown%'
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.target_loc_id) AS COUNT
   FROM era_cdb_v3.letters
   JOIN locations ON locations.locations_id = letters.target_loc_id
   WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND target_loc_id NOT LIKE 'unknown%'
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
