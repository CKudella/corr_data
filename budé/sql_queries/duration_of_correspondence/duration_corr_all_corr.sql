SELECT C.correspondents_id,
       C.name_in_edition,
       LEAST(IFNULL(X.FLFB, Y.FLTB), IFNULL(Y.FLTB, X.FLFB)) AS 'Beginning of the correspondence',
       GREATEST(IFNULL(X.LLFB, Y.LLTB), IFNULL(Y.LLTB, X.LLFB)) AS 'End of the correspondence'
FROM
  (SELECT DISTINCT CA.correspondents_id,
                   CA.name_in_edition
   FROM bude_cdb.correspondents AS CA) AS C
LEFT OUTER JOIN
  (SELECT DISTINCT XA.recipient_id,
                   MIN(XA.send_date_computable1) AS FLFB,
                   MAX(XA.send_date_computable1) AS LLFB
   FROM bude_cdb.letters AS XA
   WHERE XA.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY XA.recipient_id) AS X ON C.correspondents_id = X.recipient_id
LEFT OUTER JOIN
  (SELECT DISTINCT YA.sender_id,
                   MIN(YA.send_date_computable1) AS FLTB,
                   MAX(YA.send_date_computable1) AS LLTB
   FROM bude_cdb.letters AS YA
   WHERE YA.recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
   GROUP BY YA.sender_id) AS Y ON C.correspondents_id = Y.sender_id
WHERE correspondents_id != 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
