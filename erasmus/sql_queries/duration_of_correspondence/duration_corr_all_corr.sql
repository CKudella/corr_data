SELECT C.correspondents_id,
       C.name_in_edition,
       LEAST(IFNULL(X.FLFE, Y.FLTE), IFNULL(Y.FLTE, X.FLFE)) AS 'Beginning of the correspondence',
       GREATEST(IFNULL(X.LLFE, Y.LLTE), IFNULL(Y.LLTE, X.LLFE)) AS 'End of the correspondence'
FROM
  (SELECT DISTINCT CA.correspondents_id,
                   CA.name_in_edition
   FROM era_cdb.correspondents AS CA) AS C
LEFT OUTER JOIN
  (SELECT DISTINCT XA.recipient_id,
                   MIN(XA.send_date_computable1) AS FLFE,
                   MAX(XA.send_date_computable1) AS LLFE
   FROM era_cdb.letters AS XA
   WHERE XA.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY XA.recipient_id) AS X ON C.correspondents_id = X.recipient_id
LEFT OUTER JOIN
  (SELECT DISTINCT YA.sender_id,
                   MIN(YA.send_date_computable1) AS FLTE,
                   MAX(YA.send_date_computable1) AS LLTE
   FROM era_cdb.letters AS YA
   WHERE YA.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
   GROUP BY YA.sender_id) AS Y ON C.correspondents_id = Y.sender_id
WHERE correspondents_id != '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
