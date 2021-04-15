SELECT DISTINCT XA.sender_id,
                MIN(XA.send_date_computable1) AS FLTE,
                MAX(XA.send_date_computable1) AS LLTE
FROM wpirck_cdb_v1.letters AS XA
WHERE XA.recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND XA.sender_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM wpirck_cdb_v1.letters
     WHERE sender_id = 'pirckheimer_willibald_viaf_27173507')
GROUP BY XA.sender_id
