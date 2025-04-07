SELECT correspondents_id
FROM bude_cdb.correspondents
WHERE correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM bude_cdb.letters)
  AND correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM bude_cdb.letters)
GROUP BY correspondents_id
