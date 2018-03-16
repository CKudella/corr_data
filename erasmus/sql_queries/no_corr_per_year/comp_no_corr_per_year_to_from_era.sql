
SELECT A.Year,
       B.NoCorrEppFromEra AS 'Number of correspondents Erasmus writes to this year',
       C.NoCorrEppToEra AS 'Number of correspondents writing letters to Erasmus this year'
FROM
  (SELECT DISTINCT send_date_year1 AS 'Year'
   FROM letters) AS A
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT recipient_id) AS NoCorrEppFromEra
   FROM letters
   WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
     AND recipient_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS B ON B.Year = A.Year
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrEppToEra
   FROM letters
   WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
     AND sender_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS C ON C.Year = A.Year
GROUP BY A.Year
ORDER BY A.Year ASC
