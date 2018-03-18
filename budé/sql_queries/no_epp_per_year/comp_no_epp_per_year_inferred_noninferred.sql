SELECT Z.Year,
       X.NoInferred AS 'Number of letters with inferred send date',
       Y.NoNonInferred AS 'Number of letters with non-inferred send date'
FROM
  (SELECT DISTINCT send_date_year1 AS YEAR
   FROM budé_cdb_v1.letters) AS Z
LEFT OUTER JOIN
  (SELECT DISTINCT XA.send_date_year1 AS YEAR,
                   COUNT(*) AS NoInferred
   FROM budé_cdb_v1.letters AS XA
   WHERE XA.letters_id NOT LIKE '%ck2%'
     AND XA.send_date_inferred = '1'
   GROUP BY XA.send_date_year1) AS X ON X.Year = Z.Year
LEFT OUTER JOIN
  (SELECT DISTINCT YA.send_date_year1 AS YEAR,
                   COUNT(*) AS NoNonInferred
   FROM budé_cdb_v1.letters YA
   WHERE YA.letters_id NOT LIKE '%ck2%'
     AND YA.send_date_inferred = '0'
   GROUP BY YA.send_date_year1) AS Y ON Y.Year = Z.Year
ORDER BY Z.Year ASC
