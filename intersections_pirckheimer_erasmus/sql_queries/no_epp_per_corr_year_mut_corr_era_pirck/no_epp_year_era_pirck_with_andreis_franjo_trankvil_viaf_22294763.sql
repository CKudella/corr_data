
SELECT TE.Year,
       EtX.EPPEtX,
       XtE.EPPXtE,
       PtX.EPPPtX,
       XtP.EPPXtP
FROM
  (SELECT DISTINCT A.send_date_year1 AS Year
   FROM
     (SELECT DISTINCT send_date_year1
      FROM era_cdb_v3.letters
      UNION ALL SELECT DISTINCT send_date_year1
      FROM wpirck_cdb_v1.letters
      ORDER BY send_date_year1) AS A) AS TE
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPEtX
   FROM era_cdb_v3.letters
   WHERE recipient_id = 'andreis_franjo_trankvil_viaf_22294763'
     AND sender_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY send_date_year1) AS EtX ON EtX.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPXtE
   FROM era_cdb_v3.letters
   WHERE sender_id = 'andreis_franjo_trankvil_viaf_22294763'
     AND recipient_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY send_date_year1) AS XtE ON XtE.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPPtX
   FROM wpirck_cdb_v1.letters
   WHERE recipient_id = 'andreis_franjo_trankvil_viaf_22294763'
     AND sender_id = 'pirckheimer_willibald_viaf_27173507'
   GROUP BY send_date_year1) AS PtX ON PtX.send_date_year1 = TE.Year
LEFT JOIN
  (SELECT send_date_year1,
          COUNT(*) AS EPPXtP
   FROM wpirck_cdb_v1.letters
   WHERE sender_id = 'andreis_franjo_trankvil_viaf_22294763'
     AND recipient_id = 'pirckheimer_willibald_viaf_27173507'
   GROUP BY send_date_year1) AS XtP ON XtP.send_date_year1 = TE.Year
ORDER BY TE.Year ASC
