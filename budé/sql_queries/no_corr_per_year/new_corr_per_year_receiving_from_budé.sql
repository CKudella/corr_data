SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS NewCorrReceivingFromBudé
FROM bude_cdb.letters AS A
WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND send_date_year1 BETWEEN
    (SELECT MIN(send_date_year1) FROM bude_cdb.letters) AND
    (SELECT MAX(send_date_year1) FROM bude_cdb.letters)
  AND NOT EXISTS (
    SELECT 1
    FROM bude_cdb.letters AS B
    WHERE B.recipient_id = A.recipient_id
      AND B.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
      AND B.send_date_year1 < A.send_date_year1
  )
GROUP BY send_date_year1
ORDER BY send_date_year1