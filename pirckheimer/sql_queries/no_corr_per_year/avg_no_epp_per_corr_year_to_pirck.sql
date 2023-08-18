SELECT A.Year,
       B.NoEppToPirck/A.NoCorrToPirck AS 'Average number of letters sent per correspondent to Pirckheimer this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrToPirck
   FROM letters
   WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT DISTINCT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppToPirck
   FROM letters
   WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8'
     AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS B ON B.Year = A.year
GROUP BY A.Year
ORDER BY A.Year ASC
