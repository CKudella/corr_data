SELECT DISTINCT XA.sender_id,
                C.correspondents_id,
                MIN(XA.send_date_computable1) AS FLTE,
                MAX(XA.send_date_computable1) AS LLTE
FROM budé_cdb_v1.letters AS XA
JOIN correspondents AS C ON XA.sender_id = C.correspondents_id
WHERE XA.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND XA.sender_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM budé_cdb_v1.letters
     WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
GROUP BY XA.sender_id
