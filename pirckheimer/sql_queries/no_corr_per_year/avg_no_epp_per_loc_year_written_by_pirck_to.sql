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
          COUNT(DISTINCT send_date_year1) AS COUNT
   FROM letters
   JOIN wpirck_cdb_v1.locations ON locations.locations_id = letters.target_loc_id
   WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND sender_id = 'pirckheimer_willibald_viaf_27173507'
     AND target_loc_id NOT LIKE 'unknown%'
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.target_loc_id) AS COUNT
   FROM letters
   JOIN locations ON locations.locations_id = letters.target_loc_id
   WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND sender_id = 'pirckheimer_willibald_viaf_27173507'
     AND target_loc_id NOT LIKE 'unknown%'
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
