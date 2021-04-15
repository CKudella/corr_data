SELECT C.correspondents_id,
       C.name_in_edition,
       LEAST(IFNULL(X.FLFE, Y.FLTE), IFNULL(Y.FLTE, X.FLFE)) AS 'Beginning of correspondence with Pirckheimer',
       GREATEST(IFNULL(X.LLFE, Y.LLTE), IFNULL(Y.LLTE, X.LLFE)) AS 'End of the correspondence with Pirckheimer'
FROM
  (SELECT DISTINCT CA.correspondents_id,
                   CA.name_in_edition
   FROM correspondents AS CA) AS C
LEFT OUTER JOIN
  (SELECT DISTINCT XA.recipient_id,
                   MIN(XA.send_date_computable1) AS FLFE,
                   MAX(XA.send_date_computable1) AS LLFE
   FROM wpirck_cdb_v1.letters AS XA
   WHERE XA.sender_id = 'pirckheimer_willibald_viaf_27173507'
   GROUP BY XA.recipient_id) AS X ON C.correspondents_id = X.recipient_id
LEFT OUTER JOIN
  (SELECT DISTINCT YA.sender_id,
                   MIN(YA.send_date_computable1) AS FLTE,
                   MAX(YA.send_date_computable1) AS LLTE
   FROM wpirck_cdb_v1.letters AS YA
   WHERE YA.recipient_id = 'pirckheimer_willibald_viaf_27173507'
   GROUP BY YA.sender_id) AS Y ON C.correspondents_id = Y.sender_id
WHERE correspondents_id != 'pirckheimer_willibald_viaf_27173507'
