SELECT correspondents_id
FROM wpirck_cdb.correspondents
WHERE correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM wpirck_cdb.letters)
  AND correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM wpirck_cdb.letters)
GROUP BY correspondents_id
