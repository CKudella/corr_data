
SELECT TE.Year,
       EtX.EPPEtX,
       XtE.EPPXtE,
       PtX.EPPBtX,
       XtP.EPPXtB
FROM
  (SELECT DISTINCT A.send_date_year1 AS Year
   FROM
     (SELECT DISTINCT send_date_year1
      FROM era_cdb_v3.letters
      UNION ALL SELECT DISTINCT send_date_year1
      FROM budé_cdb_v1.letters
      ORDER BY send_date_year1) AS A) AS TE
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPEtX
   FROM era_cdb_v3.letters
   WHERE recipient_id = 'egnazio_giovanni_battista_viaf_100187526'
     AND sender_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY send_date_year1) AS EtX ON EtX.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPXtE
   FROM era_cdb_v3.letters
   WHERE sender_id = 'egnazio_giovanni_battista_viaf_100187526'
     AND recipient_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY send_date_year1) AS XtE ON XtE.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPBtX
   FROM budé_cdb_v1.letters
   WHERE recipient_id = 'egnazio_giovanni_battista_viaf_100187526'
     AND sender_id = 'budé_guillaume_viaf_105878228'
   GROUP BY send_date_year1) AS PtX ON PtX.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPXtB
   FROM budé_cdb_v1.letters
   WHERE sender_id = 'egnazio_giovanni_battista_viaf_100187526'
     AND recipient_id = 'budé_guillaume_viaf_105878228'
   GROUP BY send_date_year1) AS XtP ON XtP.send_date_year1 = TE.Year
ORDER BY TE.Year ASC

