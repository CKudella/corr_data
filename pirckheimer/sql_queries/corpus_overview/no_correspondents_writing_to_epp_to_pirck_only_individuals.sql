SELECT COUNT(DISTINCT sender_id) AS 'Total number correspondents (type: individual) who have written letters to Pirckheimer'
FROM letters,
     correspondents
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND correspondents.type = 'individual'
