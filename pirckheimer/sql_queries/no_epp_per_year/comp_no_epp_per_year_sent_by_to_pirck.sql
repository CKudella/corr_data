SELECT DISTINCT A.Year,
                B.NoEppSentFromPirck,
                C.NoEppSentToPirck
FROM
  (SELECT DISTINCT YEAR(send_date_computable1) AS Year
   FROM wpirck_cdb.letters
   WHERE letters_id NOT REGEXP 'ck[2-8]$'
     AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   UNION ALL SELECT DISTINCT YEAR(send_date_computable1) AS Year
   FROM wpirck_cdb.letters
   WHERE letters_id NOT REGEXP 'ck[2-8]$'
     AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080') AS A
LEFT OUTER JOIN
  (SELECT YEAR(send_date_computable1) AS Year,
          COUNT(*) AS NoEppSentFromPirck
   FROM wpirck_cdb.letters
   WHERE letters_id NOT REGEXP 'ck[2-8]$'
     AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY YEAR(send_date_computable1)) AS B ON B.Year = A.Year
LEFT OUTER JOIN
  (SELECT YEAR(send_date_computable1) AS Year,
          COUNT(*) AS NoEppSentToPirck
   FROM wpirck_cdb.letters
   WHERE letters_id NOT REGEXP 'ck[2-8]$'
     AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY YEAR(send_date_computable1)) AS C ON C.Year = A.Year
ORDER BY A.Year ASC
