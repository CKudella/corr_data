SELECT A.ModernState,
       A.Year,
       B.NoEppSentFromPirck,
       C.NoEppSentToPirck
FROM
  (SELECT DISTINCT AA.locations_modern_state AS ModernState,
                   AL.send_date_year1 AS YEAR
   FROM wpirck_cdb_v1.locations AS AA,
        letters AS AL
   WHERE AA.locations_id IN
       (SELECT DISTINCT AB.source_loc_id
        FROM wpirck_cdb_v1.letters AS AB)
     OR AA.locations_id IN
       (SELECT DISTINCT AC.target_loc_id
        FROM wpirck_cdb_v1.letters AS AC)
   GROUP BY AL.send_date_year1,
            AA.locations_modern_state) AS A
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentFromPirck,
                   send_date_year1
   FROM wpirck_cdb_v1.letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY locations_modern_state,
            send_date_year1
   ORDER BY send_date_year1 ASC) AS B ON B.ModernState = A.ModernState
AND B.send_date_year1 = A.Year
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentToPirck,
                   send_date_year1
   FROM wpirck_cdb_v1.letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY locations_modern_state,
            send_date_year1
   ORDER BY send_date_year1 ASC) AS C ON C.ModernState = A.ModernState
AND C.send_date_year1 = A.Year
