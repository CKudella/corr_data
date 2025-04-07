SELECT Y.locations_name_modern AS 'Location Name',
       X.locations_lat AS 'Latitude',
       X.locations_lng AS 'Longitude',
       X.count AS 'Number of years Budé writes letters to this location',
       Y.count AS 'Number of letters written by Budé to this location',
       Y.COUNT/X.COUNT AS 'Average number of letters written by Budé to this location per year'
FROM
  (SELECT locations_name_modern,
          locations_lat,
          locations_lng,
          COUNT(DISTINCT COALESCE(send_date_year1, 'unknown')) AS COUNT
   FROM bude_cdb_v1.letters
   JOIN bude_cdb_v1.locations ON locations.locations_id = letters.target_loc_id
   WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND target_loc_id NOT LIKE 'unknown%'
     AND send_date_year1 IS NOT NULL
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.target_loc_id) AS COUNT
   FROM bude_cdb_v1.letters
   JOIN bude_cdb_v1.locations ON locations.locations_id = letters.target_loc_id
   WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND target_loc_id NOT LIKE 'unknown%'
     AND send_date_year1 IS NOT NULL
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
