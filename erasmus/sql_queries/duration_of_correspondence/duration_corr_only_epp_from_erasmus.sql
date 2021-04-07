SELECT DISTINCT XA.recipient_id,
                   MIN(XA.send_date_computable1) AS FLFE,
                   MAX(XA.send_date_computable1) AS LLFE
   FROM era_cdb_v3.letters AS XA
   WHERE XA.sender_id = 'erasmus_desiderius_viaf_95982394'
   GROUP BY XA.recipient_id
