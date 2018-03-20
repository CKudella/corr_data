SELECT COUNT(DISTINCT sender_id) AS 'Total number of correspondents who have written letters to Erasmus'
FROM era_cdb_v3.letters
WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
  AND sender_id != 'unnamed_person_viaf_not_applicable'
