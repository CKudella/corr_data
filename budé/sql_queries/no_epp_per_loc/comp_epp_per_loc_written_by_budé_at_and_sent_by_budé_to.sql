SELECT Z.LocationName,
       Z.Latitude,
       Z.Longitude,
       X.NoLettersWrittenByBudéTO,
       Y.NoLettersWrittenBYBudéAT
FROM (
        (SELECT DISTINCT ZB.locations_name_modern AS LocationName,
                         ZB.locations_lat AS Latitude,
                         ZB.locations_lng AS Longitude
         FROM letters AS ZA,
              locations AS ZB
         WHERE ZB.locations_id = ZA.target_loc_id
           AND ZA.letters_id NOT LIKE '%ck2'
           AND ZA.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
           AND ZA.target_loc_id NOT LIKE 'unknown%'
         GROUP BY ZB.locations_name_modern
         ORDER BY ZB.locations_name_modern DESC)
      UNION
        (SELECT DISTINCT ZB.locations_name_modern AS LocationName,
                         ZB.locations_lat AS Latitude,
                         ZB.locations_lng AS Longitude
         FROM letters AS ZA,
              locations AS ZB
         WHERE ZB.locations_id = ZA.source_loc_id
           AND ZA.letters_id NOT LIKE '%ck2'
           AND ZA.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
           AND ZA.source_loc_id NOT LIKE 'unknown%'
         GROUP BY ZB.locations_name_modern
         ORDER BY ZB.locations_name_modern DESC)) AS Z
LEFT OUTER JOIN
  (SELECT XB.locations_name_modern AS LocationName,
          XB.locations_lat AS 'Latitude',
          XB.locations_lng AS 'Longitude',
          COUNT(XA.target_loc_id) AS NoLettersWrittenByBudéTO
   FROM letters AS XA
   JOIN locations AS XB ON XB.locations_id = XA.target_loc_id
   WHERE XA.letters_id NOT LIKE '%ck2'
     AND XA.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND XA.target_loc_id NOT LIKE 'unknown%'
   GROUP BY XA.target_loc_id
   ORDER BY COUNT(XA.target_loc_id) DESC) AS X ON X.LocationName = Z.LocationName
LEFT OUTER JOIN
  (SELECT YB.locations_name_modern AS LocationName,
          YB.locations_lat AS 'Latitude',
          YB.locations_lng AS 'Longitude',
          COUNT(YA.source_loc_id) AS NoLettersWrittenBYBudéAT
   FROM letters AS YA
   JOIN locations AS YB ON YB.locations_id = YA.source_loc_id
   WHERE YA.letters_id NOT LIKE '%ck2'
     AND YA.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND YA.source_loc_id NOT LIKE 'unknown%'
   GROUP BY YA.source_loc_id
   ORDER BY COUNT(YA.source_loc_id) DESC) AS Y ON Y.LocationName = Z.LocationName
