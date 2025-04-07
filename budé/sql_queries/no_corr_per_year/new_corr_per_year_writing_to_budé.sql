SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToBudé
FROM bude_cdb_v1.letters AS A
WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND send_date_year1 BETWEEN
    (SELECT MIN(send_date_year1) FROM bude_cdb_v1.letters) AND
    (SELECT MAX(send_date_year1) FROM bude_cdb_v1.letters)
  AND NOT EXISTS (
    SELECT 1
    FROM bude_cdb_v1.letters AS B
    WHERE B.sender_id = A.sender_id
      AND B.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
      AND B.send_date_year1 < A.send_date_year1
  )
GROUP BY send_date_year1
ORDER BY send_date_year1