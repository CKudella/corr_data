SELECT correspondents_id
FROM budé_cdb_v1.correspondents
WHERE correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM budé_cdb_v1.letters)
  AND correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM budé_cdb_v1.letters)
GROUP BY correspondents_id
