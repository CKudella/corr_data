
SELECT TE.Year,
       EtX.EPPEtX,
       XtE.EPPXtE,
       PtX.EPPBtX,
       XtP.EPPXtB
FROM
  (SELECT DISTINCT A.send_date_year1 AS Year
   FROM
     (SELECT DISTINCT send_date_year1
      FROM era_cdb.letters
      UNION ALL SELECT DISTINCT send_date_year1
      FROM bude_cdb.letters
      ORDER BY send_date_year1) AS A) AS TE
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPEtX
   FROM era_cdb.letters
   WHERE recipient_id = '5375f20d-1943-4735-b423-abf59baadfaa'
     AND sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY send_date_year1) AS EtX ON EtX.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPXtE
   FROM era_cdb.letters
   WHERE sender_id = '5375f20d-1943-4735-b423-abf59baadfaa'
     AND recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY send_date_year1) AS XtE ON XtE.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPBtX
   FROM bude_cdb.letters
   WHERE recipient_id = '5375f20d-1943-4735-b423-abf59baadfaa'
     AND sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY send_date_year1) AS PtX ON PtX.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPXtB
   FROM bude_cdb.letters
   WHERE sender_id = '5375f20d-1943-4735-b423-abf59baadfaa'
     AND recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY send_date_year1) AS XtP ON XtP.send_date_year1 = TE.Year
ORDER BY TE.Year ASC
