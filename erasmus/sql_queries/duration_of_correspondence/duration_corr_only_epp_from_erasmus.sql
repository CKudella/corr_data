SELECT DISTINCT XA.recipient_id,
                C.name_in_edition,
                MIN(XA.send_date_computable1) AS 'Beginning of the correspondence',
                MAX(XA.send_date_computable1) AS 'End of the correspondence'
FROM era_cdb.letters AS XA
JOIN era_cdb.correspondents AS C ON XA.recipient_id = C.correspondents_id
WHERE XA.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
  AND XA.recipient_id NOT IN
    (SELECT DISTINCT sender_id
     FROM era_cdb.letters
     WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf')
GROUP BY XA.recipient_id
