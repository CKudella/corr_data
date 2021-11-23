SELECT Z.ModernState,
       B.NoEppFromPirck AS 'Number of letters Pirckheimer sent to this modern state',
       C.NoEppToPirck AS 'Number of letters sent from this modern state to Pirckheimer'
FROM (
        (SELECT DISTINCT XB.locations_modern_state AS ModernState
         FROM letters AS XA,
              locations AS XB
         WHERE XB.locations_id = XA.target_loc_id
           AND XA.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
           AND XA.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
         GROUP BY XB.locations_modern_state
         ORDER BY COUNT(*) DESC)
      UNION
        (SELECT DISTINCT YB.locations_modern_state AS ModernState
         FROM letters AS YA,
              locations AS YB
         WHERE YB.locations_id = YA.source_loc_id
           AND YA.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
           AND YA.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
         GROUP BY YB.locations_modern_state
         ORDER BY YB.locations_modern_state DESC)) AS Z
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppFromPirck
   FROM letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS B ON B.ModernState = Z.ModernState
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppToPirck
   FROM letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY locations_modern_state
   ORDER BY COUNT(*) DESC) AS C ON C.ModernState = Z.ModernState
ORDER BY (B.NoEppFromPirck + C.NoEppToPirck) DESC
