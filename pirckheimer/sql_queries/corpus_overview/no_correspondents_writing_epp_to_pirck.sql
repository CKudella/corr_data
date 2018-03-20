SELECT COUNT(DISTINCT sender_id) AS 'Total number of correspondents who have written letters to Pirckheimer'
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
  AND sender_id != 'unnamed_person_viaf_not_applicable'
