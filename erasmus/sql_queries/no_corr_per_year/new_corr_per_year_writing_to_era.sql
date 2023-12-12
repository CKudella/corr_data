SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToEra
FROM era_cdb_v3.letters AS A
WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND send_date_year1 BETWEEN
    (SELECT MIN(send_date_year1) FROM era_cdb_v3.letters) AND
    (SELECT MAX(send_date_year1) FROM era_cdb_v3.letters)
  AND NOT EXISTS (
    SELECT 1
    FROM era_cdb_v3.letters AS B
    WHERE B.sender_id = A.sender_id
      AND B.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
      AND B.send_date_year1 < A.send_date_year1
  )
GROUP BY send_date_year1
ORDER BY send_date_year1