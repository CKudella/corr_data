SELECT A.Year,
       B.NoEppFromPirck/A.NoCorrFromPirck AS 'Average number of letters sent by Pirckheimer per correspondent this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT recipient_id) AS NoCorrFromPirck
   FROM wpirck_cdb_v1.letters
   WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT DISTINCT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppFromPirck
   FROM wpirck_cdb_v1.letters
   WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS B ON B.Year = A.year
GROUP BY A.Year
ORDER BY A.Year ASC
