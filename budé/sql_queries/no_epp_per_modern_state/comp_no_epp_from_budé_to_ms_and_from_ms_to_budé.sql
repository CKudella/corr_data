SELECT Z.ModernState,
       B.NoEppFromBudé AS 'Number of letters Budé sent to this modern state',
       C.NoEppToBudé AS 'Number of letters sent from this modern state to Budé'
FROM (
        (SELECT DISTINCT XB.locations_modern_state AS ModernState
         FROM budé_cdb_v1.letters AS XA,
              budé_cdb_v1.locations AS XB
         WHERE XB.locations_id = XA.target_loc_id
           AND XA.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
         GROUP BY XB.locations_modern_state
         ORDER BY COUNT(*) DESC)
      UNION
        (SELECT DISTINCT YB.locations_modern_state AS ModernState
         FROM budé_cdb_v1.letters AS YA,
              budé_cdb_v1.locations AS YB
         WHERE YB.locations_id = YA.source_loc_id
           AND YA.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
         GROUP BY YB.locations_modern_state
         ORDER BY YB.locations_modern_state DESC)) AS Z
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppFromBudé
   FROM budé_cdb_v1.letters,
        budé_cdb_v1.locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS B ON B.ModernState = Z.ModernState
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppToBudé
   FROM budé_cdb_v1.letters,
        budé_cdb_v1.locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS C ON C.ModernState = Z.ModernState
ORDER BY (B.NoEppFromBudé + C.NoEppToBudé) DESC
