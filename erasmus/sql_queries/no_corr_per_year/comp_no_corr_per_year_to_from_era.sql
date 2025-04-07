
SELECT A.Year,
       B.NoCorrEppFromEra AS 'Number of correspondents Erasmus writes to this year',
       C.NoCorrEppToEra AS 'Number of correspondents writing letters to Erasmus this year'
FROM
  (SELECT DISTINCT send_date_year1 AS 'Year'
   FROM era_cdb.letters) AS A
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT recipient_id) AS NoCorrEppFromEra
   FROM era_cdb.letters
   WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS B ON B.Year = A.Year
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrEppToEra
   FROM era_cdb.letters
   WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS C ON C.Year = A.Year
ORDER BY A.Year ASC
