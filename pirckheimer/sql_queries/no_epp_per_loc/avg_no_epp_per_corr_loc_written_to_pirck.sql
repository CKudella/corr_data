SELECT Y.locations_name_modern AS 'Location Name',
       X.locations_lat AS 'Latitude',
       X.locations_lng AS 'Longitude',
       X.count AS 'Number of correspondents writing to Pirckheimer',
       Y.count AS 'Number of letters written to Pirckheimer',
       Y.COUNT/X.COUNT AS 'Average Number of Letters'
FROM
  (SELECT locations_name_modern,
          locations_lat,
          locations_lng,
          COUNT(DISTINCT sender_id) AS COUNT
   FROM wpirck_cdb.letters
   JOIN wpirck_cdb.locations ON locations.locations_id = letters.source_loc_id
   WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND source_loc_id NOT LIKE 'unknown%'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.target_loc_id) AS COUNT
   FROM wpirck_cdb.letters
   JOIN locations ON locations.locations_id = letters.source_loc_id
   WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND source_loc_id NOT LIKE 'unknown%'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
