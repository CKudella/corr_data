SELECT COUNT(DISTINCT sender_id) AS 'Total number correspondents (type: individual) who have written letters to Erasmus'
FROM era_cdb_v3.letters,
     era_cdb_v3.correspondents
WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
  AND correspondents.type = 'individual'
