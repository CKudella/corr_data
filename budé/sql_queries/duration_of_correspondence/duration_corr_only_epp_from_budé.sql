SELECT DISTINCT XA.recipient_id,
                MIN(XA.send_date_computable1) AS FLFE,
                MAX(XA.send_date_computable1) AS LLFE
FROM budé_cdb_v1.letters AS XA
WHERE XA.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND XA.recipient_id NOT IN
    (SELECT DISTINCT sender_id
     FROM budé_cdb_v1.letters
     WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
GROUP BY XA.recipient_id
