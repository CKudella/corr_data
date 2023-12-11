SELECT A.Year,
       B.NoEppToEra/A.NoCorrToEra AS 'Average number of letters sent per correspondent to Erasmus this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrToEra
   FROM era_cdb_v3.letters
   WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT DISTINCT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppToEra
   FROM era_cdb_v3.letters
   WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'     
   GROUP BY send_date_year1) AS B ON B.Year = A.year
GROUP BY A.Year
ORDER BY A.Year ASC
