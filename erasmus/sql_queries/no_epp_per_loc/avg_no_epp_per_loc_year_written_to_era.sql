SELECT Y.locations_name_modern AS 'Location Name',
       X.locations_lat AS 'Latitude',
       X.locations_lng AS 'Longitude',
       X.count AS 'Number of years letters are written from this location to Erasmus',
       Y.count AS 'Number of letters written from this location to Erasmus',
       Y.COUNT/X.COUNT AS 'Average Number of Letters written from this location to Erasmus per year'
FROM
  (SELECT locations_name_modern,
          locations_lat,
          locations_lng,
          COUNT(DISTINCT COALESCE(send_date_year1, 'unknown')) AS COUNT
   FROM era_cdb.letters
   JOIN era_cdb.locations ON locations.locations_id = letters.source_loc_id
   WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND source_loc_id NOT LIKE 'unknown%'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.target_loc_id) AS COUNT
   FROM era_cdb.letters
   JOIN locations ON locations.locations_id = letters.source_loc_id
   WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND source_loc_id NOT LIKE 'unknown%'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
