SELECT COUNT(DISTINCT recipient_id) AS 'Total number of correspondents who have received letters from Pirckheimer'
FROM letters
WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
  AND recipient_id != 'unnamed_person_viaf_unknown'
