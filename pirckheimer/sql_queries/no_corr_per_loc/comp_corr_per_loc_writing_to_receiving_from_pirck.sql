SELECT Z.locations_id,
       Z.LocationName AS 'Location Name Modern',
       Z.Latitude,
       Z.Longitude,
       X.NoCorrToPirck,
       Y.NoCorrFromPirck
FROM
  (SELECT ZA.locations_id,
          ZA.locations_name_modern LocationName,
          ZA.locations_lat AS Latitude,
          ZA.locations_lng AS Longitude
   FROM wpirck_cdb.locations AS ZA
   WHERE ZA.locations_id IN
       (SELECT DISTINCT source_loc_id
        FROM wpirck_cdb.letters)
     OR ZA.locations_id IN
       (SELECT DISTINCT target_loc_id
        FROM wpirck_cdb.letters)) AS Z
LEFT OUTER JOIN
  (SELECT XB.locations_id,
          COUNT(DISTINCT XA.sender_id) AS NoCorrToPirck
   FROM wpirck_cdb.letters AS XA
   JOIN locations AS XB ON XB.locations_id = XA.source_loc_id
   WHERE XA.sender_id != 'd9233b24-a98c-4279-8065-e2ab70c0d080'
    AND XA.source_loc_id NOT LIKE 'unknown%'
   GROUP BY XA.source_loc_id
   ORDER BY COUNT(DISTINCT sender_id) DESC) AS X ON X.locations_id = Z.locations_id
LEFT OUTER JOIN
  (SELECT YB.locations_id,
          COUNT(DISTINCT YA.recipient_id) AS NoCorrFromPirck
   FROM wpirck_cdb.letters AS YA
   JOIN locations AS YB ON YB.locations_id = YA.target_loc_id
   WHERE YA.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
    AND YA.target_loc_id NOT LIKE 'unknown%'
   GROUP BY YA.target_loc_id
   ORDER BY COUNT(DISTINCT recipient_id) DESC) AS Y ON Y.locations_id = Z.locations_id
WHERE NoCorrToPirck IS NOT NULL
  OR NoCorrFromPirck IS NOT NULL
