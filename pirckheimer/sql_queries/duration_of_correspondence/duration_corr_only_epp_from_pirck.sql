SELECT DISTINCT XA.recipient_id,
                MIN(XA.send_date_computable1) AS FLFE,
                MAX(XA.send_date_computable1) AS LLFE
FROM wpirck_cdb_v1.letters AS XA
WHERE XA.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND XA.recipient_id NOT IN
    (SELECT DISTINCT sender_id
     FROM wpirck_cdb_v1.letters
     WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080')
GROUP BY XA.recipient_id
