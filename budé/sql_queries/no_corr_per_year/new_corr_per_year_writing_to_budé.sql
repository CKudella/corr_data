SELECT YEAR(send_date_computable1) AS 'Year',
       COUNT(DISTINCT sender_id) AS 'NewCorrWritingToBudé'
FROM bude_cdb.letters AS A
WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND YEAR(send_date_computable1) BETWEEN
    (SELECT MIN(YEAR(send_date_computable1)) FROM bude_cdb.letters) AND
    (SELECT MAX(YEAR(send_date_computable1)) FROM bude_cdb.letters)
  AND NOT EXISTS (
    SELECT 1
    FROM bude_cdb.letters AS B
    WHERE B.sender_id = A.sender_id
      AND B.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
      AND YEAR(B.send_date_computable1) < YEAR(A.send_date_computable1)
  )
GROUP BY YEAR(send_date_computable1)
ORDER BY YEAR(send_date_computable1)
