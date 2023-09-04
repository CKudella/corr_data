SELECT DISTINCT XA.sender_id,
                C.name_in_edition,
                MIN(XA.send_date_computable1) AS 'Beginning of the correspondence',
                MAX(XA.send_date_computable1) AS 'End of the correspondence'
FROM wpirck_cdb_v1.letters AS XA
JOIN wpirck_cdb_v1.correspondents AS C ON XA.sender_id = C.correspondents_id
WHERE XA.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
  AND XA.sender_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM wpirck_cdb_v1.letters
     WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080')
GROUP BY XA.sender_id
