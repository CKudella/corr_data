SELECT DISTINCT A.send_date_year1,
                B.NoEppSentFromEra,
                C.NoEppSentToEra
FROM
  (SELECT DISTINCT send_date_year1
   FROM letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'erasmus_desiderius_viaf_95982394'
   UNION ALL SELECT DISTINCT send_date_year1
   FROM letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = 'erasmus_desiderius_viaf_95982394') AS A
LEFT OUTER JOIN
  (SELECT send_date_year1,
          COUNT(*) AS NoEppSentFromEra
   FROM letters
   WHERE letters_id NOT LIKE '%ck2'
     AND sender_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY send_date_year1) AS B ON B.send_date_year1 = A.send_date_year1
LEFT OUTER JOIN
  (SELECT send_date_year1,
          COUNT(*) AS NoEppSentToEra
   FROM letters
   WHERE letters_id NOT LIKE '%ck2'
     AND recipient_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY send_date_year1) AS C ON C.send_date_year1 = A.send_date_year1
ORDER BY A.send_date_year1 ASC
