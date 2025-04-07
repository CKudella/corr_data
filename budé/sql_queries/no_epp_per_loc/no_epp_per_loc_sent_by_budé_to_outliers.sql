SELECT B.locations_name_modern,
       A.send_date_year1 AS YEAR,
       COUNT(*) AS COUNT
FROM bude_cdb.letters AS A,
     locations AS B
WHERE A.target_loc_id = B.locations_id
  AND A.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND A.target_loc_id NOT LIKE 'unknown%'
  AND A.target_loc_id IN
    (SELECT C.target_loc_id
     FROM
       (SELECT DISTINCT D.target_loc_id,
                        COUNT(D.target_loc_id) AS NoEppFromBudé
        FROM bude_cdb.letters AS D
        JOIN locations AS E ON E.locations_id = D.target_loc_id
        WHERE D.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
          AND D.target_loc_id NOT LIKE 'unknown%'
        GROUP BY D.target_loc_id
        ORDER BY COUNT(D.target_loc_id) DESC) AS C
     WHERE C.NoEppFromBudé > 8)
GROUP BY A.target_loc_id,
         A.send_date_year1
ORDER BY A.target_loc_id,
         A.send_date_year1 ASC
