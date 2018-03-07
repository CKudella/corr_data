SELECT COUNT(DISTINCT recipient_id) AS 'Total number of correspondents who have received letters from Erasmus'
FROM era_cdb_v3.letters
WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
  AND recipient_id != 'unnamed_person_viaf_unknown'
