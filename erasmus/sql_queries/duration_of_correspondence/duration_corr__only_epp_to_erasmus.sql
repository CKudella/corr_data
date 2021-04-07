SELECT DISTINCT XA.sender_id,
                   MIN(XA.send_date_computable1) AS FLTE,
                   MAX(XA.send_date_computable1) AS LLTE
   FROM era_cdb_v3.letters AS XA
   WHERE XA.recipient_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY XA.sender_id
