SELECT Z.locations_id,
       X.LocationName,
       X.Latitude,
       X.Longitude,
       X.NoCorrToEra,
       Y.NoCorrFromEra
FROM
  (SELECT ZA.locations_id
   FROM locations as ZA) AS Z
INNER JOIN
  (SELECT XB.locations_id,
          XB.locations_name_modern AS 'LocationName',
          XB.locations_lat AS Latitude,
          XB.locations_lng AS Longitude,
          COUNT(DISTINCT XA.sender_id) AS NoCorrToEra
   FROM letters AS XA
   JOIN locations AS XB  ON XB.locations_id = XA.source_loc_id
   WHERE XA.sender_id != 'erasmus_desiderius_viaf_95982394'
   GROUP BY XA.source_loc_id
   ORDER BY COUNT(DISTINCT sender_id) DESC) AS X ON X.locations_id = Z.locations_id
INNER JOIN
  (SELECT YB.locations_id,
          YB.locations_name_modern AS 'LocationName',
          YB.locations_lat AS Latitude,
          YB.locations_lng AS Longitude,
          COUNT(DISTINCT YA.recipient_id) AS NoCorrFromEra
   FROM letters AS YA
   JOIN locations AS YB ON YB.locations_id = YA.target_loc_id
   WHERE YA.sender_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY YA.target_loc_id
   ORDER BY COUNT(DISTINCT recipient_id) DESC) AS Y ON Y.locations_id = Z.locations_id
