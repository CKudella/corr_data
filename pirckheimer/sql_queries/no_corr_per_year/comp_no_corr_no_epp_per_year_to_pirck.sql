SELECT A.Year,
       A.NoCorrToPirck AS 'Number of correspondents writing letters to Pirckheimer this year',
       B.NoEppToPirck AS 'Number of letters sent to Pirckheimer this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrToPirck
   FROM wpirck_cdb_v1.letters
   WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppToPirck
   FROM wpirck_cdb_v1.letters
   WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS B ON B.Year = A.year
ORDER BY A.Year ASC
