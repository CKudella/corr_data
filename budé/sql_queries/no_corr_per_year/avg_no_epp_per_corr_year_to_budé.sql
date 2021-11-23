SELECT A.Year,
       B.NoEppToBudé/A.NoCorrToBudé AS 'Average number of letters sent per correspondent to Budé this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrToBudé
   FROM budé_cdb_v1.letters
   WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT DISTINCT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppToBudé
   FROM budé_cdb_v1.letters
   WHERE letters_id NOT LIKE '%ck2%'
     AND recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS B ON B.Year = A.year
GROUP BY A.Year
ORDER BY A.Year ASC
