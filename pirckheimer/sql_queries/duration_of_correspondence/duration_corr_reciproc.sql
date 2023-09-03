SELECT X.recipient_id AS Correspondent,
       C.name_in_edition,
       LEAST(X.FLFE,X.LLFE,Y.FLTE,Y.LLTE) AS 'Start of correspondence',
       GREATEST(X.FLFE,X.LLFE,Y.FLTE,Y.LLTE) AS 'End of correspondence'
FROM
  (SELECT DISTINCT recipient_id,
                   MIN(send_date_computable1) AS FLFE,
                   MAX(send_date_computable1) AS LLFE
   FROM wpirck_cdb_v1.letters
   WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY recipient_id) AS X
INNER JOIN
  (SELECT DISTINCT sender_id,
                   MIN(send_date_computable1) AS FLTE,
                   MAX(send_date_computable1) AS LLTE
   FROM letters
   WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
   GROUP BY sender_id) AS Y ON X.recipient_id = Y.sender_id
INNER JOIN correspondents AS C ON X.recipient_id = C.correspondents_id
