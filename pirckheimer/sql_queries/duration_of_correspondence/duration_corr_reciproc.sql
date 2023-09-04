SELECT X.recipient_id AS Correspondent,
       C.name_in_edition,
       LEAST(X.FLFP,X.LLFP,Y.FLTP,Y.LLTP) AS 'Beginning of the correspondence',
       GREATEST(X.FLFP,X.LLFP,Y.FLTP,Y.LLTP) AS 'End of the correspondence'
FROM
  (SELECT DISTINCT recipient_id,
                   MIN(send_date_computable1) AS FLFP,
                   MAX(send_date_computable1) AS LLFP
   FROM wpirck_cdb_v1.letters
   WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY recipient_id) AS X
INNER JOIN
  (SELECT DISTINCT sender_id,
                   MIN(send_date_computable1) AS FLTP,
                   MAX(send_date_computable1) AS LLTP
   FROM wpirck_cdb_v1.letters
   WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY sender_id) AS Y ON X.recipient_id = Y.sender_id
INNER JOIN wpirck_cdb_v1.correspondents AS C ON X.recipient_id = C.correspondents_id
