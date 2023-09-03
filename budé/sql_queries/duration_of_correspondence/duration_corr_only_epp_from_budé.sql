SELECT DISTINCT XA.recipient_id,
                C.correspondents_id,
                MIN(XA.send_date_computable1) AS FLFE,
                MAX(XA.send_date_computable1) AS LLFE
FROM budé_cdb_v1.letters AS XA
JOIN correspondents AS C ON XA.recipient_id = C.correspondents_id
WHERE XA.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND XA.recipient_id NOT IN
    (SELECT DISTINCT sender_id
     FROM budé_cdb_v1.letters
     WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
GROUP BY XA.recipient_id
