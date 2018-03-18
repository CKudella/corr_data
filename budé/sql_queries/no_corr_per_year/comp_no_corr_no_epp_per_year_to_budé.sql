SELECT A.Year,
       A.NoCorrToBudé AS 'Number of correspondents writing letters to Budé this year',
       B.NoEppToBudé AS 'Number of letters sent to Budé this year'
FROM
  (SELECT send_date_year1 AS 'Year',
          COUNT(DISTINCT sender_id) AS NoCorrToBudé
   FROM budé_cdb_v1.letters
   WHERE recipient_id = 'budé_guillaume_viaf_105878228'
     AND sender_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS A
INNER JOIN
  (SELECT DISTINCT send_date_year1 AS 'Year',
                   COUNT(letters_id) AS NoEppToBudé
   FROM budé_cdb_v1.letters
   WHERE letters_id NOT LIKE '%ck2%'
     AND recipient_id = 'budé_guillaume_viaf_105878228'
     AND sender_id != 'unnamed_person_viaf_not_applicable'
   GROUP BY send_date_year1) AS B ON B.Year = A.year
GROUP BY A.Year
ORDER BY A.Year ASC
