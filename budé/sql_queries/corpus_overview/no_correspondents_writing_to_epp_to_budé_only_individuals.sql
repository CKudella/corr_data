SELECT COUNT(DISTINCT sender_id) AS 'Total number of correspondents (type: individual) who have written letters to Budé'
FROM letters,
     correspondents
WHERE recipient_id = 'budé_guillaume_viaf_105878228'
  AND correspondents.type = 'individual'
