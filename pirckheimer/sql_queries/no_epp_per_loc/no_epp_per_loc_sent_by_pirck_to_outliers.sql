SELECT B.locations_name_modern,
       A.send_date_year1 AS YEAR,
       COUNT(*) AS COUNT
FROM wpirck_cdb_v1.letters AS A,
     locations AS B
WHERE A.target_loc_id = B.locations_id
  AND A.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND A.target_loc_id NOT LIKE 'unknown%'
  AND A.target_loc_id IN
    (SELECT C.target_loc_id
     FROM
       (SELECT DISTINCT D.target_loc_id,
                        COUNT(D.target_loc_id) AS NoEppFromPirck
        FROM wpirck_cdb_v1.letters AS D
        JOIN locations AS E ON E.locations_id = D.target_loc_id
        WHERE D.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
          AND D.target_loc_id NOT LIKE 'unknown%'
        GROUP BY D.target_loc_id
        ORDER BY COUNT(D.target_loc_id) DESC) AS C
     WHERE C.NoEppFromPirck > 18)
GROUP BY A.target_loc_id,
         A.send_date_year1
ORDER BY A.target_loc_id,
         A.send_date_year1 ASC
