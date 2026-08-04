SELECT YEAR(send_date_computable1) AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToEra
FROM era_cdb.letters AS A
WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND YEAR(send_date_computable1) BETWEEN
    (SELECT MIN(YEAR(send_date_computable1)) FROM era_cdb.letters) AND
    (SELECT MAX(YEAR(send_date_computable1)) FROM era_cdb.letters)
  AND NOT EXISTS (
    SELECT 1
    FROM era_cdb.letters AS B
    WHERE B.sender_id = A.sender_id
      AND B.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
      AND YEAR(B.send_date_computable1) < YEAR(A.send_date_computable1)
  )
GROUP BY YEAR(send_date_computable1)
ORDER BY YEAR(send_date_computable1)