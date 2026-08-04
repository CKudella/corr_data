SELECT YEAR(send_date_computable1) AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM wpirck_cdb.letters AS A
WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND YEAR(send_date_computable1) BETWEEN
    (SELECT MIN(YEAR(send_date_computable1)) FROM wpirck_cdb.letters) AND
    (SELECT MAX(YEAR(send_date_computable1)) FROM wpirck_cdb.letters)
  AND NOT EXISTS (
    SELECT 1
    FROM wpirck_cdb.letters AS B
    WHERE B.sender_id = A.sender_id
      AND B.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
      AND B.YEAR(send_date_computable1) < A.YEAR(send_date_computable1)
  )
GROUP BY YEAR(send_date_computable1)
ORDER BY YEAR(send_date_computable1)
