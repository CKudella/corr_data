SELECT DISTINCT XA.recipient_id,
                MIN(XA.send_date_computable1) AS FLFE,
                MAX(XA.send_date_computable1) AS LLFE
FROM budé_cdb_v1.letters AS XA
WHERE XA.sender_id = 'budé_guillaume_viaf_105878228'
  AND XA.recipient_id NOT IN
    (SELECT DISTINCT sender_id
     FROM budé_cdb_v1.letters
     WHERE recipient_id = 'budé_guillaume_viaf_105878228')
GROUP BY XA.recipient_id
