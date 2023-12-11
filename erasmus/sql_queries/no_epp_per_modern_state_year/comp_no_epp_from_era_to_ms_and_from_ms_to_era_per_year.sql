SELECT A.ModernState,
       A.Year,
       B.NoEppSentFromEra,
       C.NoEppSentToEra
FROM
  (SELECT DISTINCT AA.locations_modern_state AS ModernState,
                   AL.send_date_year1 AS YEAR
   FROM era_cdb_v3.locations AS AA,
        letters AS AL
   WHERE AA.locations_id IN
       (SELECT DISTINCT AB.source_loc_id
        FROM era_cdb_v3.letters AS AB)
     OR AA.locations_id IN
       (SELECT DISTINCT AC.target_loc_id
        FROM era_cdb_v3.letters AS AC)
   GROUP BY AL.send_date_year1,
            AA.locations_modern_state) AS A
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentFromEra,
                   send_date_year1
   FROM era_cdb_v3.letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY locations_modern_state,
            send_date_year1
   ORDER BY send_date_year1 ASC) AS B ON B.ModernState = A.ModernState
AND B.send_date_year1 = A.Year
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentToEra,
                   send_date_year1
   FROM era_cdb_v3.letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY locations_modern_state,
            send_date_year1
   ORDER BY send_date_year1 ASC) AS C ON C.ModernState = A.ModernState
AND C.send_date_year1 = A.Year
