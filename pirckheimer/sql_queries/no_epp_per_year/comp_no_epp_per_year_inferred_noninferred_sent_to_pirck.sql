SELECT Z.Year,
       X.NoInferred AS 'Number of letters with inferred send date',
       Y.NoNonInferred AS 'Number of letters with non-inferred send date'
FROM
  (SELECT DISTINCT send_date_year1 AS YEAR
   FROM wpirck_cdb.letters) AS Z
LEFT OUTER JOIN
  (SELECT DISTINCT XA.send_date_year1 AS YEAR,
                   COUNT(*) AS NoInferred
   FROM wpirck_cdb.letters AS XA
   WHERE XA.letters_id NOT REGEXP 'ck[2-8]$'
     AND XA.send_date_inferred = '1'
     AND XA.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY XA.send_date_year1) AS X ON X.Year = Z.Year
LEFT OUTER JOIN
  (SELECT DISTINCT YA.send_date_year1 AS YEAR,
                   COUNT(*) AS NoNonInferred
   FROM wpirck_cdb.letters YA
   WHERE YA.letters_id NOT REGEXP 'ck[2-8]$'
     AND YA.send_date_inferred = '0'
     AND YA.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY YA.send_date_year1) AS Y ON Y.Year = Z.Year
ORDER BY Z.Year ASC
