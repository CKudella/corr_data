SELECT A.Year,
       A.NoCorrToBudé AS 'Number of correspondents writing letters to Budé this year',
       B.NoEppToBudé AS 'Number of letters sent to Budé this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrToBudé
   FROM bude_cdb.letters
   WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppToBudé
   FROM bude_cdb.letters
   WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS B ON B.Year = A.year
ORDER BY A.Year ASC
