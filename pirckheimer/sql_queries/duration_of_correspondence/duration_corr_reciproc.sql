SELECT X.recipient_id AS Correspondent,
       LEAST(X.FLFE,X.LLFE,Y.FLTE,Y.LLTE) AS 'Start of correspondence',
       GREATEST(X.FLFE,X.LLFE,Y.FLTE,Y.LLTE) AS 'End of correspondence'
FROM
  (SELECT DISTINCT recipient_id,
                   MIN(send_date_computable1) AS FLFE,
                   MAX(send_date_computable1) AS LLFE
   FROM letters
   WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
   GROUP BY recipient_id) AS X
INNER JOIN
  (SELECT DISTINCT sender_id,
                   MIN(send_date_computable1) AS FLTE,
                   MAX(send_date_computable1) AS LLTE
   FROM letters
   WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
   GROUP BY sender_id) AS Y ON X.recipient_id = Y.sender_id
