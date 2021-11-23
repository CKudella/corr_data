SELECT DISTINCT XA.sender_id,
                MIN(XA.send_date_computable1) AS FLTE,
                MAX(XA.send_date_computable1) AS LLTE
FROM budé_cdb_v1.letters AS XA
WHERE XA.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND XA.sender_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM budé_cdb_v1.letters
     WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
GROUP BY XA.sender_id
