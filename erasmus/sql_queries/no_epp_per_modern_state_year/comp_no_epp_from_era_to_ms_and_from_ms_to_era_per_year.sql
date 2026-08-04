SELECT A.ModernState,
       A.Year,
       B.NoEppSentFromEra,
       C.NoEppSentToEra
FROM
  (SELECT DISTINCT AA.locations_modern_state AS ModernState,
                   YEAR(AL.send_date_computable1) AS Year
   FROM era_cdb.locations AS AA,
        letters AS AL
   WHERE AA.locations_id IN
       (SELECT DISTINCT AB.source_loc_id
        FROM era_cdb.letters AS AB)
     OR AA.locations_id IN
       (SELECT DISTINCT AC.target_loc_id
        FROM era_cdb.letters AS AC)
   GROUP BY YEAR(AL.send_date_computable1),
            AA.locations_modern_state) AS A
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentFromEra,
                   YEAR(send_date_computable1) AS Year
   FROM era_cdb.letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY locations_modern_state,
            YEAR(send_date_computable1)
   ORDER BY YEAR(send_date_computable1) ASC) AS B ON B.ModernState = A.ModernState
AND B.Year = A.Year
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentToEra,
                   YEAR(send_date_computable1) AS Year
   FROM era_cdb.letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY locations_modern_state,
            YEAR(send_date_computable1)
   ORDER BY YEAR(send_date_computable1) ASC) AS C ON C.ModernState = A.ModernState
AND C.Year = A.Year
