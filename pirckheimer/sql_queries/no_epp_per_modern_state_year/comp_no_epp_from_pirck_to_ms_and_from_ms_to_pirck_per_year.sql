SELECT A.ModernState,
       A.Year,
       B.NoEppSentFromPirck,
       C.NoEppSentToPirck
FROM
  (SELECT DISTINCT AA.locations_modern_state AS ModernState,
                   YEAR(AL.send_date_computable1) AS Year
   FROM wpirck_cdb.locations AS AA,
        letters AS AL
   WHERE AA.locations_id IN
       (SELECT DISTINCT AB.source_loc_id
        FROM wpirck_cdb.letters AS AB)
     OR AA.locations_id IN
       (SELECT DISTINCT AC.target_loc_id
        FROM wpirck_cdb.letters AS AC)
   GROUP BY YEAR(AL.send_date_computable1),
            AA.locations_modern_state) AS A
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentFromPirck,
                   YEAR(send_date_computable1) AS Year
   FROM wpirck_cdb.letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY locations_modern_state,
            YEAR(send_date_computable1)
   ORDER BY YEAR(send_date_computable1) ASC) AS B ON B.ModernState = A.ModernState
AND B.Year = A.Year
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentToPirck,
                   YEAR(send_date_computable1) AS Year
   FROM wpirck_cdb.letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY locations_modern_state,
            YEAR(send_date_computable1)
   ORDER BY YEAR(send_date_computable1) ASC) AS C ON C.ModernState = A.ModernState
AND C.Year = A.Year
