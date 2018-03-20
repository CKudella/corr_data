SELECT COUNT(DISTINCT recipient_id) AS 'Total number of correspondents (type: individual) Pirckheimer has written letters to'
FROM letters,
     correspondents
WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
  AND recipient_id != 'unnamed_person_viaf_not_applicable'
  AND correspondents.type = 'individual'
