
SELECT A.Year,
       B.NoCorrEppFromBudé AS 'Number of correspondents Budé writes to this year',
       C.NoCorrEppToBudé AS 'Number of correspondents writing letters to Budé this year'
FROM
  (SELECT DISTINCT send_date_year1 AS 'Year'
   FROM letters) AS A
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT recipient_id) AS NoCorrEppFromBudé
   FROM letters
   WHERE sender_id = 'budé_guillaume_viaf_105878228'
     AND recipient_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS B ON B.Year = A.Year
LEFT OUTER JOIN
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrEppToBudé
   FROM letters
   WHERE recipient_id = 'budé_guillaume_viaf_105878228'
     AND sender_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS C ON C.Year = A.Year
GROUP BY A.Year
ORDER BY A.Year ASC
