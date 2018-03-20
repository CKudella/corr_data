SELECT DISTINCT A.send_date_year1,
                B.NoEppSentFromPirck,
                C.NoEppSentToPirck
FROM
  (SELECT DISTINCT send_date_year1
   FROM letters
   WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND sender_id = 'pirckheimer_willibald_viaf_27173507'
   UNION ALL SELECT DISTINCT send_date_year1
   FROM letters
   WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND recipient_id = 'pirckheimer_willibald_viaf_27173507') AS A
LEFT OUTER JOIN
  (SELECT send_date_year1,
          COUNT(*) AS NoEppSentFromPirck
   FROM letters
   WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND sender_id = 'pirckheimer_willibald_viaf_27173507'
   GROUP BY send_date_year1) AS B ON B.send_date_year1 = A.send_date_year1
LEFT OUTER JOIN
  (SELECT send_date_year1,
          COUNT(*) AS NoEppSentToPirck
   FROM letters
   WHERE letters_id NOT REGEXP '[0-7]ck2|ck3|ck4|ck5|ck6|ck7|ck8]'
     AND recipient_id = 'pirckheimer_willibald_viaf_27173507'
   GROUP BY send_date_year1) AS C ON C.send_date_year1 = A.send_date_year1
ORDER BY A.send_date_year1 ASC
