SELECT DISTINCT A.Year,
                B.NoEppSentFromBudé,
                C.NoEppSentToBudé
FROM
  (SELECT DISTINCT YEAR(send_date_computable1) AS 'Year'
   FROM bude_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   UNION ALL SELECT DISTINCT YEAR(send_date_computable1)
   FROM bude_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b') AS A
LEFT OUTER JOIN
  (SELECT YEAR(send_date_computable1) AS 'Year',
          COUNT(*) AS NoEppSentFromBudé
   FROM bude_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY YEAR(send_date_computable1)) AS B ON B.Year = A.Year
LEFT OUTER JOIN
  (SELECT YEAR(send_date_computable1) AS 'Year',
          COUNT(*) AS NoEppSentToBudé
   FROM bude_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY YEAR(send_date_computable1)) AS C ON C.Year = A.Year
ORDER BY A.Year ASC
