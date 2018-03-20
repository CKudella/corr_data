
SELECT A.Year,
       B.NoCorrEppFromPirck AS 'Number of correspondents Pirckheimer writes to this year',
       C.NoCorrEppToPirck AS 'Number of correspondents writing letters to Pirckheimer this year'
FROM
  (SELECT DISTINCT send_date_year1 AS 'Year'
   FROM letters) AS A
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT recipient_id) AS NoCorrEppFromPirck
   FROM letters
   WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
     AND recipient_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS B ON B.Year = A.Year
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrEppToPirck
   FROM letters
   WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
     AND sender_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS C ON C.Year = A.Year
GROUP BY A.Year
ORDER BY A.Year ASC
