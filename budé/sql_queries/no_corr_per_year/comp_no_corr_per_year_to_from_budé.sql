
SELECT A.Year,
       B.NoCorrEppFromBudé AS 'Number of correspondents Budé writes to this year',
       C.NoCorrEppToBudé AS 'Number of correspondents writing letters to Budé this year'
FROM
  (SELECT DISTINCT send_date_year1 AS 'Year'
   FROM bude_cdb.letters) AS A
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT recipient_id) AS NoCorrEppFromBudé
   FROM bude_cdb.letters
   WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS B ON B.Year = A.Year
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrEppToBudé
   FROM bude_cdb.letters
   WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS C ON C.Year = A.Year
ORDER BY A.Year ASC
