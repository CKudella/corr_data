SELECT B.locations_name_modern,
       A.send_date_year1 AS YEAR,
       COUNT(*) AS COUNT
FROM era_cdb_v3.letters AS A,
     locations AS B
WHERE A.source_loc_id = B.locations_id
  AND A.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND A.source_loc_id NOT LIKE 'unknown%'
  AND A.source_loc_id IN
    (SELECT C.source_loc_id
     FROM
       (SELECT DISTINCT D.source_loc_id,
                        COUNT(D.source_loc_id) AS NoEppToEra
        FROM era_cdb_v3.letters AS D
        JOIN locations AS E ON E.locations_id = D.source_loc_id
        WHERE D.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
          AND D.source_loc_id NOT LIKE 'unknown%'
        GROUP BY D.source_loc_id
        ORDER BY COUNT(D.source_loc_id) DESC) AS C
     WHERE C.NoEppToEra >= 9)
GROUP BY A.source_loc_id,
         A.send_date_year1
ORDER BY A.source_loc_id,
         A.send_date_year1 ASC
