SELECT DISTINCT A.Year,
                B.NoEppSentFromEra,
                C.NoEppSentToEra
FROM
  (SELECT DISTINCT YEAR(send_date_computable1) AS Year
   FROM era_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   UNION ALL SELECT DISTINCT YEAR(send_date_computable1) AS Year
   FROM era_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf') AS A
LEFT OUTER JOIN
  (SELECT YEAR(send_date_computable1) AS Year,
          COUNT(*) AS NoEppSentFromEra
   FROM era_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY YEAR(send_date_computable1)) AS B ON B.Year = A.Year
LEFT OUTER JOIN
  (SELECT YEAR(send_date_computable1) AS Year,
          COUNT(*) AS NoEppSentToEra
   FROM era_cdb.letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY YEAR(send_date_computable1)) AS C ON C.Year = A.Year
ORDER BY A.Year ASC
