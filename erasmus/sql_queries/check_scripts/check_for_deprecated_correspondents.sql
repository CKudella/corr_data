SELECT correspondents_id
FROM era_cdb.correspondents
WHERE correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM era_cdb.letters)
  AND correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM era_cdb.letters)
GROUP BY correspondents_id
