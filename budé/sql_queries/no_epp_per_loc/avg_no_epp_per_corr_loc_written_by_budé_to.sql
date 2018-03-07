SELECT y.locations_name_modern AS 'Location Name',
       x.locations_lat AS 'Latitude',
       x.locations_lng AS 'Longitude',
       x.count AS 'Number of correspondents Budé writes to',
       y.count AS 'Number of letters written by Budé',
       Y.COUNT/X.COUNT AS 'Average number of letters'
FROM
  (SELECT locations_name_modern,
          locations_lat,
          locations_lng,
          COUNT(DISTINCT recipient_id) AS COUNT
   FROM letters
   JOIN budé_cdb_v1.locations ON locations.locations_id = letters.target_loc_id
   WHERE sender_id = 'budé_guillaume_viaf_105878228'
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.target_loc_id) AS COUNT
   FROM letters
   JOIN locations ON locations.locations_id = letters.target_loc_id
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'budé_guillaume_viaf_105878228'
   GROUP BY target_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
