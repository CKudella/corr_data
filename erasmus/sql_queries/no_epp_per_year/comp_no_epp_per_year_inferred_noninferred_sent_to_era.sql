SELECT Z.Year,
       X.NoInferred AS 'Number of letters with inferred send date',
       Y.NoNonInferred AS 'Number of letters with non-inferred send date'
FROM
  (SELECT DISTINCT send_date_year1 AS YEAR
   FROM era_cdb.letters) AS Z
LEFT OUTER JOIN
  (SELECT DISTINCT XA.send_date_year1 AS YEAR,
                   COUNT(*) AS NoInferred
   FROM era_cdb.letters AS XA
   WHERE XA.letters_id NOT LIKE '%ck2%'
     AND XA.send_date_inferred = '1'
     AND XA.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY XA.send_date_year1) AS X ON X.Year = Z.Year
LEFT OUTER JOIN
  (SELECT DISTINCT YA.send_date_year1 AS YEAR,
                   COUNT(*) AS NoNonInferred
   FROM era_cdb.letters YA
   WHERE YA.letters_id NOT LIKE '%ck2%'
     AND YA.send_date_inferred = '0'
     AND YA.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY YA.send_date_year1) AS Y ON Y.Year = Z.Year
ORDER BY Z.Year ASC
