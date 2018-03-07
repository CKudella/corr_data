SELECT COUNT(DISTINCT recipient_id) AS 'Total number of correspondents (type: individual) who have received letters by Budé'
FROM letters,
     correspondents
WHERE sender_id = 'budé_guillaume_viaf_105878228'
  AND recipient_id != 'unnamed_person_viaf_unknown'
  AND correspondents.type = 'individual'
