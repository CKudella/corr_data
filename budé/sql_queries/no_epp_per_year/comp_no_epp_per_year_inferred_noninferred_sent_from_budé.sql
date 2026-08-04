SELECT Z.Year,
       X.NoInferred AS 'Number of letters with inferred send date',
       Y.NoNonInferred AS 'Number of letters with non-inferred send date'
FROM
  (SELECT DISTINCT YEAR(send_date_computable1) AS 'Year'
   FROM bude_cdb.letters) AS Z
LEFT OUTER JOIN
  (SELECT DISTINCT YEAR(XA.send_date_computable1) AS 'Year',
                   COUNT(*) AS NoInferred
   FROM bude_cdb.letters AS XA
   WHERE XA.letters_id NOT LIKE '%ck2%'
     AND XA.send_date_inferred = '1'
     AND XA.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY YEAR(XA.send_date_computable1)) AS X ON X.Year = Z.Year
LEFT OUTER JOIN
  (SELECT DISTINCT YEAR(YA.send_date_computable1) AS 'Year',
                   COUNT(*) AS NoNonInferred
   FROM bude_cdb.letters YA
   WHERE YA.letters_id NOT LIKE '%ck2%'
     AND YA.send_date_inferred = '0'
     AND YA.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY YEAR(YA.send_date_computable1)) AS Y ON Y.Year = Z.Year
ORDER BY Z.Year ASC
