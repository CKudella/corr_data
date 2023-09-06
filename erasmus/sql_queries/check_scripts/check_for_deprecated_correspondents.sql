SELECT correspondents_id
FROM era_cdb_v3.correspondents
WHERE correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM era_cdb_v3.letters)
  AND correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM era_cdb_v3.letters)
GROUP BY correspondents_id
