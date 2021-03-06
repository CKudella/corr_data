SELECT A.ModernState,
       A.Year,
       B.NoEppSentFromEra,
       C.NoEppSentToEra
FROM
  (SELECT DISTINCT AA.locations_modern_state AS ModernState,
                   AL.send_date_year1 AS YEAR
   FROM locations AS AA,
        letters AS AL
   WHERE AA.locations_id IN
       (SELECT DISTINCT AB.source_loc_id
        FROM letters AS AB)
     OR AA.locations_id IN
       (SELECT DISTINCT AC.target_loc_id
        FROM letters AS AC)
   GROUP BY AL.send_date_year1,
            AA.locations_modern_state) AS A
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentFromEra,
                   send_date_year1
   FROM letters,
        locations
   WHERE locations.locations_id = letters.target_loc_id
     AND letters_id NOT LIKE '%ck2'
     AND sender_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY locations_modern_state,
            send_date_year1
   ORDER BY send_date_year1 ASC) AS B ON B.ModernState = A.ModernState
AND B.send_date_year1 = A.Year
LEFT OUTER JOIN
  (SELECT DISTINCT locations.locations_modern_state AS ModernState,
                   COUNT(*) AS NoEppSentToEra,
                   send_date_year1
   FROM letters,
        locations
   WHERE locations.locations_id = letters.source_loc_id
     AND letters_id NOT LIKE '%ck2'
     AND recipient_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY locations_modern_state,
            send_date_year1
   ORDER BY send_date_year1 ASC) AS C ON C.ModernState = A.ModernState
AND C.send_date_year1 = A.Year
