SELECT DISTINCT XA.recipient_id,
                MIN(XA.send_date_computable1) AS FLFE,
                MAX(XA.send_date_computable1) AS LLFE
FROM era_cdb_v3.letters AS XA
WHERE XA.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND XA.recipient_id NOT IN
    (SELECT DISTINCT sender_id
     FROM era_cdb_v3.letters
     WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf')
GROUP BY XA.recipient_id
