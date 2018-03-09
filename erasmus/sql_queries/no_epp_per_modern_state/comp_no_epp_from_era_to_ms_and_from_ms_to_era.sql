SELECT Z.ModernState,
       B.NoEppFromEra AS 'Number of letters Erasmus sent to this modern state',
       C.NoEppToEra AS 'Number of letters sent from this modern state to Erasmus'
FROM (
        (SELECT DISTINCT XB.locations_modern_state AS ModernState
         FROM letters AS XA,
              locations AS XB
         WHERE XB.locations_id = XA.target_loc_id
           AND XA.letters_id NOT LIKE '%ck2'
           AND XA.sender_id = 'erasmus_desiderius_viaf_95982394'
         GROUP BY XB.locations_modern_state
         ORDER BY COUNT(*) DESC)
      UNION
        (SELECT DISTINCT YB.locations_modern_state AS ModernState
         FROM letters AS YA,
              locations AS YB
         WHERE YB.locations_id = YA.source_loc_id
           AND YA.letters_id NOT LIKE '%ck2'
           AND YA.recipient_id = 'erasmus_desiderius_viaf_95982394'
         GROUP BY YB.locations_modern_state
         ORDER BY YB.locations_modern_state DESC)) AS Z
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppFromEra
   FROM letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND letters_id NOT LIKE '%ck2'
     AND sender_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS B ON B.ModernState = Z.ModernState
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppToEra
   FROM letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND letters_id NOT LIKE '%ck2'
     AND recipient_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS C ON C.ModernState = Z.ModernState
ORDER BY (B.NoEppFromEra + C.NoEppToEra) DESC
