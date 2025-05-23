SELECT Y.locations_name_modern AS 'Location Name',
       X.locations_lat AS 'Latitude',
       X.locations_lng AS 'Longitude',
       X.count AS 'Number of years Pirckheimer writes letters to this location',
       Y.count AS 'Number of letters written by Pirckheimer to this location',
       Y.COUNT/X.COUNT AS 'Average number of letters written by Pirckheimer to this location per year'
FROM
  (SELECT locations_name_modern,
          locations_lat,
          locations_lng,
          COUNT(DISTINCT COALESCE(send_date_year1, 'unknown')) AS COUNT
   FROM wpirck_cdb.letters
   JOIN wpirck_cdb.locations ON locations.locations_id = letters.target_loc_id
   WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND target_loc_id NOT LIKE 'unknown%'
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.target_loc_id) AS COUNT
   FROM wpirck_cdb.letters
   JOIN locations ON locations.locations_id = letters.target_loc_id
   WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND target_loc_id NOT LIKE 'unknown%'
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
