SELECT X.recipient_id AS Correspondent,
       C.name_in_edition,
       LEAST(X.FLFE,X.LLFE,Y.FLTE,Y.LLTE) AS 'Beginning of the correspondence',
       GREATEST(X.FLFE,X.LLFE,Y.FLTE,Y.LLTE) AS 'End of the correspondence'
FROM
  (SELECT DISTINCT recipient_id,
                   MIN(send_date_computable1) AS FLFE,
                   MAX(send_date_computable1) AS LLFE
   FROM era_cdb_v3.letters
   WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY recipient_id) AS X
INNER JOIN
  (SELECT DISTINCT sender_id,
                   MIN(send_date_computable1) AS FLTE,
                   MAX(send_date_computable1) AS LLTE
   FROM era_cdb_v3.letters
   WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY sender_id) AS Y ON X.recipient_id = Y.sender_id
INNER JOIN era_cdb_v3.correspondents AS C ON X.recipient_id = C.correspondents_id
