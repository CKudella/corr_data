SELECT A.Year,
       A.NoCorrFromBudé AS 'Number of correspondents to whom Budé wrote this year',
       B.NoEppFromBudé AS 'Number of letters sent by Budé this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT recipient_id) AS NoCorrFromBudé
   FROM bude_cdb.letters
   WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT DISTINCT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppFromBudé
   FROM bude_cdb.letters
   WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS B ON B.Year = A.year
GROUP BY A.Year
ORDER BY A.Year ASC
