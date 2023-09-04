SELECT C.correspondents_id,
       C.name_in_edition,
       LEAST(IFNULL(X.FLFP, Y.FLTP), IFNULL(Y.FLTP, X.FLFP)) AS 'Beginning of the correspondence',
       GREATEST(IFNULL(X.LLFP, Y.LLTP), IFNULL(Y.LLTP, X.LLFP)) AS 'End of the correspondence'
FROM
  (SELECT DISTINCT CA.correspondents_id,
                   CA.name_in_edition
   FROM wpirck_cdb_v1.correspondents AS CA) AS C
LEFT OUTER JOIN
  (SELECT DISTINCT XA.recipient_id,
                   MIN(XA.send_date_computable1) AS FLFP,
                   MAX(XA.send_date_computable1) AS LLFP
   FROM wpirck_cdb_v1.letters AS XA
   WHERE XA.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY XA.recipient_id) AS X ON C.correspondents_id = X.recipient_id
LEFT OUTER JOIN
  (SELECT DISTINCT YA.sender_id,
                   MIN(YA.send_date_computable1) AS FLTP,
                   MAX(YA.send_date_computable1) AS LLTP
   FROM wpirck_cdb_v1.letters AS YA
   WHERE YA.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY YA.sender_id) AS Y ON C.correspondents_id = Y.sender_id
WHERE correspondents_id != 'd9233b24-a98c-4279-8065-e2ab70c0d080'
