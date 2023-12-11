SELECT Y.locations_name_modern AS 'Location Name',
       X.locations_lat AS 'Latitude',
       X.locations_lng AS 'Longitude',
       X.count AS 'Number of years Budé writes letters from this location',
       Y.count AS 'Number of letters written by Budé from this location',
       Y.COUNT/X.COUNT AS 'Average number of letters written by Budé from this location per year'
FROM
  (SELECT locations_name_modern,
          locations_lat,
          locations_lng,
          COUNT(DISTINCT COALESCE(send_date_year1, 'unknown')) AS COUNT
   FROM budé_cdb_v1.letters
   JOIN budé_cdb_v1.locations ON locations.locations_id = letters.source_loc_id
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND source_loc_id NOT LIKE 'unknown%'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.source_loc_id) AS COUNT
   FROM budé_cdb_v1.letters
   JOIN budé_cdb_v1.locations ON locations.locations_id = letters.source_loc_id
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND source_loc_id NOT LIKE 'unknown%'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
