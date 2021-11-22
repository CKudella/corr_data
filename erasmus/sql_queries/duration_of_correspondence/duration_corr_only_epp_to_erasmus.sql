SELECT DISTINCT XA.sender_id,
                MIN(XA.send_date_computable1) AS FLTE,
                MAX(XA.send_date_computable1) AS LLTE
FROM era_cdb_v3.letters AS XA
WHERE XA.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND XA.sender_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM era_cdb_v3.letters
     WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf')
GROUP BY XA.sender_id
