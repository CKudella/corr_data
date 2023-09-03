SELECT DISTINCT XA.sender_id,
                C.correspondents_id,
                MIN(XA.send_date_computable1) AS FLTE,
                MAX(XA.send_date_computable1) AS LLTE
FROM era_cdb_v3.letters AS XA
JOIN correspondents AS C ON XA.sender_id = C.correspondents_id
WHERE XA.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND XA.sender_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM era_cdb_v3.letters
     WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf')
GROUP BY XA.sender_id
