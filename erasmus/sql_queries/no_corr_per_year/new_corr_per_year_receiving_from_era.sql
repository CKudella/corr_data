SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS NewCorrReceivingFromEra
FROM era_cdb.letters AS A
WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND send_date_year1 BETWEEN
    (SELECT MIN(send_date_year1) FROM era_cdb.letters) AND
    (SELECT MAX(send_date_year1) FROM era_cdb.letters)
  AND NOT EXISTS (
    SELECT 1
    FROM era_cdb.letters AS B
    WHERE B.recipient_id = A.recipient_id
      AND B.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
      AND B.send_date_year1 < A.send_date_year1
  )
GROUP BY send_date_year1
ORDER BY send_date_year1