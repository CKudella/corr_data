SELECT Z.locations_id,
       Z.LocationName AS 'Location Name Modern',
       Z.Latitude,
       Z.Longitude,
       X.NoCorrToEra,
       Y.NoCorrFromEra
FROM
  (SELECT ZA.locations_id,
          ZA.locations_name_modern LocationName,
          ZA.locations_lat AS Latitude,
          ZA.locations_lng AS Longitude
   FROM era_cdb.locations AS ZA
   WHERE ZA.locations_id IN
       (SELECT DISTINCT source_loc_id
        FROM era_cdb.letters)
     OR ZA.locations_id IN
       (SELECT DISTINCT target_loc_id
        FROM era_cdb.letters)) AS Z
LEFT OUTER JOIN
  (SELECT XB.locations_id,
          COUNT(DISTINCT XA.sender_id) AS NoCorrToEra
   FROM era_cdb.letters AS XA
   JOIN locations AS XB ON XB.locations_id = XA.source_loc_id
   WHERE XA.sender_id != '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND XA.source_loc_id NOT LIKE 'unknown%'
   GROUP BY XA.source_loc_id
   ORDER BY COUNT(DISTINCT sender_id) DESC) AS X ON X.locations_id = Z.locations_id
LEFT OUTER JOIN
  (SELECT YB.locations_id,
          COUNT(DISTINCT YA.recipient_id) AS NoCorrFromEra
   FROM era_cdb.letters AS YA
   JOIN locations AS YB ON YB.locations_id = YA.target_loc_id
   WHERE YA.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND YA.target_loc_id NOT LIKE 'unknown%'
   GROUP BY YA.target_loc_id
   ORDER BY COUNT(DISTINCT recipient_id) DESC) AS Y ON Y.locations_id = Z.locations_id
WHERE NoCorrToEra IS NOT NULL
  OR NoCorrFromEra IS NOT NULL
