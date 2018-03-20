SELECT Z.Year,
       X.NoInferred AS 'Number of letters with inferred send date',
       Y.NoNonInferred AS 'Number of letters with non-inferred send date'
FROM
  (SELECT DISTINCT send_date_year1 AS YEAR
   FROM letters) AS Z
LEFT OUTER JOIN
  (SELECT DISTINCT XA.send_date_year1 AS YEAR,
                   COUNT(*) AS NoInferred
   FROM letters AS XA
   WHERE XA.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND XA.send_date_inferred = '1'
   GROUP BY XA.send_date_year1) AS X ON X.Year = Z.Year
LEFT OUTER JOIN
  (SELECT DISTINCT YA.send_date_year1 AS YEAR,
                   COUNT(*) AS NoNonInferred
   FROM letters YA
   WHERE YA.letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND YA.send_date_inferred = '0'
   GROUP BY YA.send_date_year1) AS Y ON Y.Year = Z.Year
ORDER BY Z.Year ASC
