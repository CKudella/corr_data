SELECT COUNT(DISTINCT recipient_id) AS 'Total number of correspondents Erasmus has written letters to'
FROM era_cdb_v3.letters
WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
  AND recipient_id != 'unnamed_person_viaf_not_applicable'
