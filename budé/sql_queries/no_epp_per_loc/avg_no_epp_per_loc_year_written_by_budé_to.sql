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
          COUNT(DISTINCT send_date_year1) AS COUNT
   FROM budé_cdb_v1.letters
   JOIN budé_cdb_v1.locations ON locations.locations_id = letters.target_loc_id
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'budé_guillaume_viaf_105878228'
     AND target_loc_id NOT LIKE 'unknown%'
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.target_loc_id) AS COUNT
   FROM budé_cdb_v1.letters
   JOIN budé_cdb_v1.locations ON locations.locations_id = letters.target_loc_id
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'budé_guillaume_viaf_105878228'
     AND target_loc_id NOT LIKE 'unknown%'
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
