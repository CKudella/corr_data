SELECT Z.LocationName,
       Z.Latitude,
       Z.Longitude,
       X.NoLettersWrittenByPirckheimerTO,
       Y.NoLettersWrittenBYPirckheimerAT
FROM (
        (SELECT DISTINCT ZB.locations_name_modern AS LocationName,
                         ZB.locations_lat AS Latitude,
                         ZB.locations_lng AS Longitude
         FROM wpirck_cdb.letters AS ZA,
              locations AS ZB
         WHERE ZB.locations_id = ZA.target_loc_id
           AND ZA.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
           AND ZA.target_loc_id NOT LIKE 'unknown%'
         GROUP BY ZB.locations_name_modern, ZB.locations_lat, ZB.locations_lng
         ORDER BY ZB.locations_name_modern DESC)
      UNION
        (SELECT DISTINCT ZB.locations_name_modern AS LocationName,
                         ZB.locations_lat AS Latitude,
                         ZB.locations_lng AS Longitude
         FROM wpirck_cdb.letters AS ZA,
              locations AS ZB
         WHERE ZB.locations_id = ZA.source_loc_id
           AND ZA.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
           AND ZA.source_loc_id NOT LIKE 'unknown%'
         GROUP BY ZB.locations_name_modern, ZB.locations_lat, ZB.locations_lng
         ORDER BY ZB.locations_name_modern DESC)) AS Z
LEFT OUTER JOIN
  (SELECT XB.locations_name_modern AS LocationName,
          XB.locations_lat AS 'Latitude',
          XB.locations_lng AS 'Longitude',
          COUNT(XA.target_loc_id) AS NoLettersWrittenByPirckheimerTO
   FROM wpirck_cdb.letters AS XA
   JOIN locations AS XB ON XB.locations_id = XA.target_loc_id
   WHERE XA.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND XA.target_loc_id NOT LIKE 'unknown%'
   GROUP BY XA.target_loc_id, XB.locations_name_modern, XB.locations_lat, XB.locations_lng
   ORDER BY COUNT(XA.target_loc_id) DESC) AS X ON X.LocationName = Z.LocationName
LEFT OUTER JOIN
  (SELECT YB.locations_name_modern AS LocationName,
          YB.locations_lat AS 'Latitude',
          YB.locations_lng AS 'Longitude',
          COUNT(YA.source_loc_id) AS NoLettersWrittenBYPirckheimerAT
   FROM wpirck_cdb.letters AS YA
   JOIN locations AS YB ON YB.locations_id = YA.source_loc_id
   WHERE YA.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND YA.source_loc_id NOT LIKE 'unknown%'
   GROUP BY YA.source_loc_id, YB.locations_name_modern, YB.locations_lat, YB.locations_lng
   ORDER BY COUNT(YA.source_loc_id) DESC) AS Y ON Y.LocationName = Z.LocationName
