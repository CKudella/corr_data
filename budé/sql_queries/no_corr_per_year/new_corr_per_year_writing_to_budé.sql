SELECT send_date_year1 AS YEAR,
       COUNT(DISTINCT sender_id) AS NewCorrWritingToBudé
FROM budé_cdb_v1.letters
WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND send_date_year1 BETWEEN
    (SELECT MIN(send_date_year1)
     FROM budé_cdb_v1.letters) AND
    (SELECT MAX(send_date_year1)
     FROM budé_cdb_v1.letters)
  AND sender_id NOT IN
    (SELECT DISTINCT sender_id
     FROM budé_cdb_v1.letters
     WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
       AND send_date_year1 < send_date_year1)
GROUP BY send_date_year1
ORDER BY send_date_year1