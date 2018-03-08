SELECT Y.locations_name_modern AS 'Location Name',
       X.locations_lat AS 'Latitude',
       X.locations_lng AS 'Longitude',
       X.count AS 'Number of correspondents writing to Budé',
       Y.count AS 'Number of letters written to Budé',
       Y.COUNT/X.COUNT AS 'Average number of letters'
FROM
  (SELECT locations_name_modern,
          locations_lat,
          locations_lng,
          COUNT(DISTINCT sender_id) AS COUNT
   FROM letters
   JOIN locations ON locations.locations_id = letters.source_loc_id
   WHERE sender_id != 'budé_guillaume_viaf_105878228'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS X
INNER JOIN
  (SELECT locations.locations_name_modern,
          COUNT(letters.source_loc_id) AS COUNT
   FROM letters
   JOIN locations ON locations.locations_id = letters.source_loc_id
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = 'budé_guillaume_viaf_105878228'
   GROUP BY source_loc_id
   ORDER BY COUNT DESC) AS Y ON X.locations_name_modern = Y.locations_name_modern
