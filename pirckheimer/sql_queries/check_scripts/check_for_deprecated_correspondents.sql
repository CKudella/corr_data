SELECT correspondents_id
FROM correspondents
WHERE correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters)
  AND correspondents_id NOT IN
    (SELECT DISTINCT recipient_id
     FROM letters)
GROUP BY correspondents_id
