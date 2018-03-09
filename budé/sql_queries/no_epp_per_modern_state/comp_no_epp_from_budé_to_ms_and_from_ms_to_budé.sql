SELECT Z.ModernState,
       B.NoEppFromBudé AS 'Number of letters Budé sent to this modern state',
       C.NoEppToBudé AS 'Number of letters sent from this modern state to Budé'
FROM (
        (SELECT DISTINCT XB.locations_modern_state AS ModernState
         FROM letters AS XA,
              locations AS XB
         WHERE XB.locations_id = XA.target_loc_id
           AND XA.letters_id NOT LIKE '%ck2'
           AND XA.sender_id = 'budé_guillaume_viaf_105878228'
         GROUP BY XB.locations_modern_state
         ORDER BY COUNT(*) DESC)
      UNION
        (SELECT DISTINCT YB.locations_modern_state AS ModernState
         FROM letters AS YA,
              locations AS YB
         WHERE YB.locations_id = YA.source_loc_id
           AND YA.letters_id NOT LIKE '%ck2'
           AND YA.recipient_id = 'budé_guillaume_viaf_105878228'
         GROUP BY YB.locations_modern_state
         ORDER BY YB.locations_modern_state DESC)) AS Z
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppFromBudé
   FROM letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND letters_id NOT LIKE '%ck2'
     AND sender_id = 'budé_guillaume_viaf_105878228'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS B ON B.ModernState = Z.ModernState
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppToBudé
   FROM letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND letters_id NOT LIKE '%ck2'
     AND recipient_id = 'budé_guillaume_viaf_105878228'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS C ON C.ModernState = Z.ModernState
ORDER BY (B.NoEppFromBudé + C.NoEppToBudé) DESC
