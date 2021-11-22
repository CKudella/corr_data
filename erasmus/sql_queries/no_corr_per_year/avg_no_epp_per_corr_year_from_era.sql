SELECT A.Year,
       B.NoEppFromEra/A.NoCorrFromEra AS 'Average number of letters sent from Erasmus per correspondent this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT recipient_id) AS NoCorrFromEra
   FROM letters
   WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT DISTINCT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppFromEra
   FROM letters
   WHERE letters_id NOT LIKE '%ck2%'
     AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS B ON B.Year = A.year
GROUP BY A.Year
ORDER BY A.Year ASC
