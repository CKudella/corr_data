SELECT DISTINCT A.send_date_year1,
                B.NoEppSentFromBudé,
                C.NoEppSentToBudé
FROM
  (SELECT DISTINCT send_date_year1
   FROM budé_cdb_v1.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   UNION ALL SELECT DISTINCT send_date_year1
   FROM budé_cdb_v1.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b') AS A
LEFT OUTER JOIN
  (SELECT send_date_year1,
          COUNT(*) AS NoEppSentFromBudé
   FROM budé_cdb_v1.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY send_date_year1) AS B ON B.send_date_year1 = A.send_date_year1
LEFT OUTER JOIN
  (SELECT send_date_year1,
          COUNT(*) AS NoEppSentToBudé
   FROM budé_cdb_v1.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY send_date_year1) AS C ON C.send_date_year1 = A.send_date_year1
ORDER BY A.send_date_year1 ASC
