SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT recipient_id) AS NewCorrReceivingFromPirck
FROM wpirck_cdb_v1.letters AS A
WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND send_date_year1 BETWEEN
    (SELECT MIN(send_date_year1) FROM wpirck_cdb_v1.letters) AND
    (SELECT MAX(send_date_year1) FROM wpirck_cdb_v1.letters)
  AND NOT EXISTS (
    SELECT 1
    FROM wpirck_cdb_v1.letters AS B
    WHERE B.recipient_id = A.recipient_id
      AND B.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
      AND B.send_date_year1 < A.send_date_year1
  )
GROUP BY send_date_year1
ORDER BY send_date_year1