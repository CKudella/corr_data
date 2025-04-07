SELECT Z.ModernState,
       B.NoEppFromPirck AS 'Number of letters Pirckheimer sent to this modern state',
       C.NoEppToPirck AS 'Number of letters sent from this modern state to Pirckheimer'
FROM (
        (SELECT DISTINCT XB.locations_modern_state AS ModernState
         FROM wpirck_cdb.letters AS XA,
              locations AS XB
         WHERE XB.locations_id = XA.target_loc_id
           AND XA.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
         GROUP BY XB.locations_modern_state
         ORDER BY COUNT(*) DESC)
      UNION
        (SELECT DISTINCT YB.locations_modern_state AS ModernState
         FROM wpirck_cdb.letters AS YA,
              locations AS YB
         WHERE YB.locations_id = YA.source_loc_id
           AND YA.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
         GROUP BY YB.locations_modern_state
         ORDER BY YB.locations_modern_state DESC)) AS Z
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppFromPirck
   FROM wpirck_cdb.letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS B ON B.ModernState = Z.ModernState
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppToPirck
   FROM wpirck_cdb.letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS C ON C.ModernState = Z.ModernState
ORDER BY (B.NoEppFromPirck + C.NoEppToPirck) DESC
