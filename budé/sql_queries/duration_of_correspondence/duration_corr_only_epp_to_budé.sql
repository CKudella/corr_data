SELECT DISTINCT XA.sender_id,
                MIN(XA.send_date_computable1) AS FLTE,
                MAX(XA.send_date_computable1) AS LLTE
FROM budé_cdb_v1.letters AS XA
WHERE XA.recipient_id = 'budé_guillaume_viaf_105878228'
  AND XA.sender_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM budé_cdb_v1.letters
     WHERE sender_id = 'budé_guillaume_viaf_105878228')
GROUP BY XA.sender_id
