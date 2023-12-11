SELECT Z.ModernState,
       B.NoEppFromEra AS 'Number of letters Erasmus sent to this modern state',
       C.NoEppToEra AS 'Number of letters sent from this modern state to Erasmus'
FROM (
        (SELECT DISTINCT XB.locations_modern_state AS ModernState
         FROM era_cdb_v3.letters AS XA,
              locations AS XB
         WHERE XB.locations_id = XA.target_loc_id
           AND XA.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
         GROUP BY XB.locations_modern_state
         ORDER BY COUNT(*) DESC)
      UNION
        (SELECT DISTINCT YB.locations_modern_state AS ModernState
         FROM era_cdb_v3.letters AS YA,
              locations AS YB
         WHERE YB.locations_id = YA.source_loc_id
           AND YA.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
         GROUP BY YB.locations_modern_state
         ORDER BY YB.locations_modern_state DESC)) AS Z
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppFromEra
   FROM era_cdb_v3.letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS B ON B.ModernState = Z.ModernState
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppToEra
   FROM era_cdb_v3.letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS C ON C.ModernState = Z.ModernState
ORDER BY (B.NoEppFromEra + C.NoEppToEra) DESC
