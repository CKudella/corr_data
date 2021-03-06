SELECT A.Year,
       A.NoCorrFromEra AS 'Number of correspondents receiving letters from Erasmus this year',
       B.NoEppFromEra AS 'Number of letters sent from Erasmus this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT recipient_id) AS NoCorrFromEra
   FROM letters
   WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
     AND recipient_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT DISTINCT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppFromEra
   FROM letters
   WHERE letters_id NOT LIKE '%ck2%'
     AND sender_id = 'erasmus_desiderius_viaf_95982394'
     AND recipient_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS B ON B.Year = A.year
GROUP BY A.Year
ORDER BY A.Year ASC
