SELECT X.recipient_id AS Correspondent,
       C.name_in_edition,
       LEAST(X.FLFB,X.LLFB,Y.FLTB,Y.LLTB) AS 'Beginning of the correspondence',
       GREATEST(X.FLFB,X.LLFB,Y.FLTB,Y.LLTB) AS 'End of the correspondence'
FROM
  (SELECT DISTINCT recipient_id,
                   MIN(send_date_computable1) AS FLFB,
                   MAX(send_date_computable1) AS LLFB
   FROM bude_cdb_v1.letters
   WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY recipient_id) AS X
INNER JOIN
  (SELECT DISTINCT sender_id,
                   MIN(send_date_computable1) AS FLTB,
                   MAX(send_date_computable1) AS LLTB
   FROM bude_cdb_v1.letters
   WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY sender_id) AS Y ON X.recipient_id = Y.sender_id
INNER JOIN bude_cdb_v1.correspondents AS C ON X.recipient_id = C.correspondents_id
