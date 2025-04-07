SELECT Z.locations_id,
       Z.LocationName AS 'Location Name Modern',
       Z.Latitude,
       Z.Longitude,
       X.NoCorrToBudé,
       Y.NoCorrFromBudé
FROM
  (SELECT ZA.locations_id,
          ZA.locations_name_modern LocationName,
          ZA.locations_lat AS Latitude,
          ZA.locations_lng AS Longitude
   FROM bude_cdb_v1.locations AS ZA
   WHERE ZA.locations_id IN
       (SELECT DISTINCT source_loc_id
        FROM bude_cdb_v1.letters)
     OR ZA.locations_id IN
       (SELECT DISTINCT target_loc_id
        FROM bude_cdb_v1.letters)) AS Z
LEFT OUTER JOIN
  (SELECT XB.locations_id,
          COUNT(DISTINCT XA.sender_id) AS NoCorrToBudé
   FROM bude_cdb_v1.letters AS XA
   JOIN bude_cdb_v1.locations AS XB ON XB.locations_id = XA.source_loc_id
   WHERE XA.sender_id != 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND XA.source_loc_id NOT LIKE 'unknown%'
   GROUP BY XA.source_loc_id
   ORDER BY COUNT(DISTINCT sender_id) DESC) AS X ON X.locations_id = Z.locations_id
LEFT OUTER JOIN
  (SELECT YB.locations_id,
          COUNT(DISTINCT YA.recipient_id) AS NoCorrFromBudé
   FROM bude_cdb_v1.letters AS YA
   JOIN bude_cdb_v1.locations AS YB ON YB.locations_id = YA.target_loc_id
   WHERE YA.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND YA.target_loc_id NOT LIKE 'unknown%'
   GROUP BY YA.target_loc_id
   ORDER BY COUNT(DISTINCT recipient_id) DESC) AS Y ON Y.locations_id = Z.locations_id
WHERE NoCorrToBudé IS NOT NULL
  OR NoCorrFromBudé IS NOT NULL
