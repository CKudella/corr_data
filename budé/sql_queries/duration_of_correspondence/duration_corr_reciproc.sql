SELECT X.recipient_id AS Correspondent,
       C.name_in_edition,
       LEAST(X.FLFE,X.LLFE,Y.FLTE,Y.LLTE) AS 'Start of correspondence',
       GREATEST(X.FLFE,X.LLFE,Y.FLTE,Y.LLTE) AS 'End of correspondence'
FROM
  (SELECT DISTINCT recipient_id,
                   MIN(send_date_computable1) AS FLFE,
                   MAX(send_date_computable1) AS LLFE
   FROM budé_cdb_v1.letters
   WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY recipient_id) AS X
INNER JOIN
  (SELECT DISTINCT sender_id,
                   MIN(send_date_computable1) AS FLTE,
                   MAX(send_date_computable1) AS LLTE
   FROM budé_cdb_v1.letters
   WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY sender_id) AS Y ON X.recipient_id = Y.sender_id
INNER JOIN correspondents AS C ON x.recipient_id = C.correspondents_id
