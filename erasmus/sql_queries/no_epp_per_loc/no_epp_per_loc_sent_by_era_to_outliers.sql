SELECT B.locations_name_modern,
       A.send_date_year1 AS YEAR,
       COUNT(*) AS COUNT
FROM era_cdb_v3.letters AS A,
     locations AS B
WHERE A.target_loc_id = B.locations_id
  AND A.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND A.target_loc_id NOT LIKE 'unknown%'
  AND A.target_loc_id IN
    (SELECT C.target_loc_id
     FROM
       (SELECT DISTINCT D.target_loc_id,
                        COUNT(D.target_loc_id) AS NoEppFromEra
        FROM era_cdb_v3.letters AS D
        JOIN locations AS E ON E.locations_id = D.target_loc_id
        WHERE D.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
          AND D.target_loc_id NOT LIKE 'unknown%'
        GROUP BY D.target_loc_id
        ORDER BY COUNT(D.target_loc_id) DESC) AS C
     WHERE C.NoEppFromEra >= 17)
GROUP BY A.target_loc_id,
         A.send_date_year1
ORDER BY A.target_loc_id,
         A.send_date_year1 ASC
