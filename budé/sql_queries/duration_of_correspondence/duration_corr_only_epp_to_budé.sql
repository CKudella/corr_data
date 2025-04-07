SELECT DISTINCT XA.sender_id,
                C.name_in_edition,
                MIN(XA.send_date_computable1) AS 'Beginning of the correspondence',
                MAX(XA.send_date_computable1) AS 'End of the correspondence'
FROM bude_cdb.letters AS XA
JOIN bude_cdb.correspondents AS C ON XA.sender_id = C.correspondents_id
WHERE XA.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
  AND XA.sender_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM bude_cdb.letters
     WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b')
GROUP BY XA.sender_id
