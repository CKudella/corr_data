SELECT Y.locations_name_modern AS 'Location Name',
       X.locations_lat AS 'Latitude',
       X.locations_lng AS 'Longitude',
       X.count AS 'Number of years letters are written from this location to Budé',
       Y.count AS 'Number of letters written from this location to Budé',
       Y.COUNT/X.COUNT AS 'Average number of letters written from this location to Budé per year'
FROM
  (SELECT locations_name_modern,
          locations_lat,
          locations_lng,
          COUNT(DISTINCT COALESCE(send_date_year1, 'unknown')) AS COUNT
   FROM bude_cdb.letters
   JOIN bude_cdb.locations ON locations.locations_id = letters.source_loc_id
   WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND source_loc_id NOT LIKE 'unknown%'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.target_loc_id) AS COUNT
   FROM bude_cdb.letters
   JOIN bude_cdb.locations ON locations.locations_id = letters.source_loc_id
   WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND source_loc_id NOT LIKE 'unknown%'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
