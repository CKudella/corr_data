
SELECT TE.Year,
       EtX.EPPEtX,
       XtE.EPPXtE,
       PtX.EPPPtX,
       XtP.EPPXtP
FROM
  (SELECT DISTINCT A.send_date_year1 AS Year
   FROM
     (SELECT DISTINCT send_date_year1
      FROM era_cdb.letters
      UNION ALL SELECT DISTINCT send_date_year1
      FROM wpirck_cdb.letters
      ORDER BY send_date_year1) AS A) AS TE
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPEtX
   FROM era_cdb.letters
   WHERE recipient_id = '8ad99d13-2ff3-4b64-b5aa-253a2613dc74'
     AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY send_date_year1) AS EtX ON EtX.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPXtE
   FROM era_cdb.letters
   WHERE sender_id = '8ad99d13-2ff3-4b64-b5aa-253a2613dc74'
     AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY send_date_year1) AS XtE ON XtE.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPPtX
   FROM wpirck_cdb.letters
   WHERE recipient_id = '8ad99d13-2ff3-4b64-b5aa-253a2613dc74'
     AND sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY send_date_year1) AS PtX ON PtX.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPXtP
   FROM wpirck_cdb.letters
   WHERE sender_id = '8ad99d13-2ff3-4b64-b5aa-253a2613dc74'
     AND recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY send_date_year1) AS XtP ON XtP.send_date_year1 = TE.Year
ORDER BY TE.Year ASC
