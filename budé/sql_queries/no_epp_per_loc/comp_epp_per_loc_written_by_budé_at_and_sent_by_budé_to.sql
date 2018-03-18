SELECT X.LocationName,
       X.Latitude,
       X.Longitude,
       X.NoLettersTOBudé,
       Y.NoLettersBYBudé
FROM
  (SELECT XB.locations_name_modern AS LocationName,
          XB.locations_lat AS 'Latitude',
          XB.locations_lng AS 'Longitude',
          COUNT(XA.source_loc_id) AS NoLettersTOBudé
   FROM budé_cdb_v1.letters AS XA
   JOIN budé_cdb_v1.locations AS XB ON XB.locations_id = XA.source_loc_id
   WHERE XA.letters_id NOT LIKE '%ck2'
     AND XA.recipient_id = 'budé_guillaume_viaf_105878228'
     AND XA.source_loc_id NOT LIKE 'unknown%'
   GROUP BY XA.source_loc_id
   ORDER BY COUNT(XA.source_loc_id) DESC) AS X
INNER JOIN
  (SELECT YB.locations_name_modern AS LocationName,
          YB.locations_lat AS 'Latitude',
          YB.locations_lng AS 'Longitude',
          COUNT(YA.source_loc_id) AS NoLettersBYBudé
   FROM budé_cdb_v1.letters AS YA
   JOIN budé_cdb_v1.locations AS YB ON YB.locations_id = YA.source_loc_id
   WHERE YA.letters_id NOT LIKE '%ck2'
     AND YA.sender_id = 'budé_guillaume_viaf_105878228'
     AND YA.source_loc_id NOT LIKE 'unknown%'
   GROUP BY YA.source_loc_id
   ORDER BY COUNT(YA.source_loc_id) DESC) AS Y ON Y.LocationName = X.LocationName
