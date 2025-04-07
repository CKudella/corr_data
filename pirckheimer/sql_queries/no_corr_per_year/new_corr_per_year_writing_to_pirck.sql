SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToPirck
FROM wpirck_cdb.letters AS A
WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND send_date_year1 BETWEEN
    (SELECT MIN(send_date_year1) FROM wpirck_cdb.letters) AND
    (SELECT MAX(send_date_year1) FROM wpirck_cdb.letters)
  AND NOT EXISTS (
    SELECT 1
    FROM wpirck_cdb.letters AS B
    WHERE B.sender_id = A.sender_id
      AND B.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
      AND B.send_date_year1 < A.send_date_year1
  )
GROUP BY send_date_year1
ORDER BY send_date_year1