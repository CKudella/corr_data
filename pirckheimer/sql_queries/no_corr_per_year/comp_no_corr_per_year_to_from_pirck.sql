SELECT A.Year,
       B.NoCorrEppFromPirck AS 'Number of correspondents Pirckheimer writes to this year',
       C.NoCorrEppToPirck AS 'Number of correspondents writing letters to Pirckheimer this year'
FROM
  (SELECT DISTINCT send_date_year1 AS 'Year'
   FROM wpirck_cdb_v1.letters) AS A
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT recipient_id) AS NoCorrEppFromPirck
   FROM wpirck_cdb_v1.letters
   WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND recipient_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS B ON B.Year = A.Year
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrEppToPirck
   FROM wpirck_cdb_v1.letters
   WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
     AND sender_id != 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
   GROUP BY send_date_year1) AS C ON C.Year = A.Year
ORDER BY A.Year ASC
