SELECT A.Year,
       A.NoCorrToEra AS 'Number of correspondents writing letters to Erasmus this year',
       B.NoEppToEra AS 'Number of letters sent to Erasmus this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrToEra
   FROM letters
   WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
     AND sender_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT DISTINCT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppToEra
   FROM letters
   WHERE letters_id NOT LIKE '%ck2%'
     AND recipient_id = 'erasmus_desiderius_viaf_95982394'
     AND sender_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS B ON B.Year = A.year
GROUP BY A.Year
ORDER BY A.Year ASC
