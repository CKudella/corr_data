SELECT B.locations_name_modern,
       A.send_date_year1 AS YEAR,
       COUNT(*) AS COUNT
FROM letters AS A,
     locations AS B
WHERE A.source_loc_id = B.locations_id
  AND A.recipient_id = 'erasmus_desiderius_viaf_95982394'
  AND A.letters_id NOT LIKE '%ck2'
  AND A.source_loc_id NOT LIKE 'unknown%'
  AND A.source_loc_id IN
    (SELECT C.source_loc_id
     FROM
       (SELECT DISTINCT D.source_loc_id,
                        COUNT(D.source_loc_id) AS NoEppToEra
        FROM letters AS D
        JOIN locations AS E ON E.locations_id = D.source_loc_id
        WHERE D.letters_id NOT LIKE '%ck2'
          AND D.recipient_id = 'erasmus_desiderius_viaf_95982394'
          AND D.source_loc_id NOT LIKE 'unknown%'
        GROUP BY D.source_loc_id
        ORDER BY COUNT(D.source_loc_id) DESC) AS C
     WHERE C.NoEppToEra > 8.5)
GROUP BY A.source_loc_id,
         A.send_date_year1
ORDER BY A.source_loc_id,
         A.send_date_year1 ASC
