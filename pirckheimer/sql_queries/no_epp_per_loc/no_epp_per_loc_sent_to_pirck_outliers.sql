SELECT B.locations_name_modern,
       A.send_date_year1 AS YEAR,
       COUNT(*) AS COUNT
FROM letters AS A,
     locations AS B
WHERE A.source_loc_id = B.locations_id
  AND A.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND A.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
  AND A.source_loc_id NOT LIKE 'unknown%'
  AND A.source_loc_id IN
    (SELECT C.source_loc_id
     FROM
       (SELECT DISTINCT D.source_loc_id,
                        COUNT(D.source_loc_id) AS NoEppToPirck
        FROM letters AS D
        JOIN locations AS E ON E.locations_id = D.source_loc_id
        WHERE D.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
          AND D.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
          AND D.source_loc_id NOT LIKE 'unknown%'
        GROUP BY D.source_loc_id
        ORDER BY COUNT(D.source_loc_id) DESC) AS C
     WHERE C.NoEppToPirck > 8.5)
GROUP BY A.source_loc_id,
         A.send_date_year1
ORDER BY A.source_loc_id,
         A.send_date_year1 ASC
