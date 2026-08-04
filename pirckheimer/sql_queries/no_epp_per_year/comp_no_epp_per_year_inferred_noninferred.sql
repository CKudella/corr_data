SELECT Z.Year,
       X.NoInferred AS 'Number of letters with inferred send date',
       Y.NoNonInferred AS 'Number of letters with non-inferred send date'
FROM
  (SELECT DISTINCT YEAR(send_date_computable1) AS Year
   FROM wpirck_cdb.letters) AS Z
LEFT OUTER JOIN
  (SELECT YEAR(XA.send_date_computable1) AS Year,
                   COUNT(*) AS NoInferred
   FROM wpirck_cdb.letters AS XA
   WHERE XA.letters_id NOT REGEXP 'ck[2-8]$'
     AND XA.send_date_inferred = '1'
   GROUP BY YEAR(XA.send_date_computable1)) AS X ON X.Year = Z.Year
LEFT OUTER JOIN
  (SELECT YEAR(YA.send_date_computable1) AS Year,
                   COUNT(*) AS NoNonInferred
   FROM wpirck_cdb.letters YA
   WHERE YA.letters_id NOT REGEXP 'ck[2-8]$'
     AND YA.send_date_inferred = '0'
   GROUP BY YEAR(YA.send_date_computable1)) AS Y ON Y.Year = Z.Year
ORDER BY Z.Year ASC
