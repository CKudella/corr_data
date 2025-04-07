SELECT DISTINCT A.send_date_year1,
                B.NoEppSentFromEra,
                C.NoEppSentToEra
FROM
  (SELECT DISTINCT send_date_year1
   FROM era_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   UNION ALL SELECT DISTINCT send_date_year1
   FROM era_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf') AS A
LEFT OUTER JOIN
  (SELECT send_date_year1,
          COUNT(*) AS NoEppSentFromEra
   FROM era_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY send_date_year1) AS B ON B.send_date_year1 = A.send_date_year1
LEFT OUTER JOIN
  (SELECT send_date_year1,
          COUNT(*) AS NoEppSentToEra
   FROM era_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY send_date_year1) AS C ON C.send_date_year1 = A.send_date_year1
ORDER BY A.send_date_year1 ASC
