SELECT COUNT(correspondents_id) AS 'Total number of correspondents (type: individual) in the dataset'
FROM era_cdb_v3.correspondents
WHERE correspondents_id NOT IN ('erasmus_desiderius_viaf_95982394',
                                'unnamed_person_viaf_not_applicable')
  AND correspondents.type = 'individual'
