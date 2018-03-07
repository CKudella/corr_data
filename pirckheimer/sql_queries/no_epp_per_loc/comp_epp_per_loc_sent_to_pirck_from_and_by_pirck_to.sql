SELECT X.LocationName,
       X.Latitude,
       X.Longitude,
       X.NoLettersWrittenTOPirckheimer,
       Y.NoLettersWrittenBYPirckheimerTO
FROM
  (SELECT XB.locations_name_modern AS LocationName,
          XB.locations_lat AS 'Latitude',
          XB.locations_lng AS 'Longitude',
          COUNT(XA.source_loc_id) AS NoLettersWrittenTOPirckheimer
   FROM letters AS XA
   JOIN locations AS XB ON XB.locations_id = XA.source_loc_id
   WHERE XA.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND XA.recipient_id = 'pirckheimer_willibald_viaf_27173507'
   GROUP BY XA.source_loc_id
   ORDER BY COUNT(XA.source_loc_id) DESC) AS X
INNER JOIN
  (SELECT YB.locations_name_modern AS LocationName,
          YB.locations_lat AS 'Latitude',
          YB.locations_lng AS 'Longitude',
          COUNT(YA.target_loc_id) AS NoLettersWrittenBYPirckheimerTO
   FROM letters AS YA
   JOIN locations AS YB ON YB.locations_id = YA.target_loc_id
   WHERE YA.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND YA.recipient_id != 'pirckheimer_willibald_viaf_27173507'
   GROUP BY YA.target_loc_id
   ORDER BY COUNT(YA.target_loc_id) DESC) AS Y ON Y.LocationName = X.LocationName
