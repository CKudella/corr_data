SELECT A.Year,
       B.NoEppFromBudé/A.NoCorrFromBudé AS 'Average number of letters sent from Budé per correspondent this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT recipient_id) AS NoCorrFromBudé
   FROM budé_cdb_v1.letters
   WHERE sender_id = 'budé_guillaume_viaf_105878228'
     AND recipient_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT DISTINCT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppFromBudé
   FROM budé_cdb_v1.letters
   WHERE letters_id NOT LIKE '%ck2%'
     AND sender_id = 'budé_guillaume_viaf_105878228'
     AND recipient_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS B ON B.Year = A.year
GROUP BY A.Year
ORDER BY A.Year ASC
