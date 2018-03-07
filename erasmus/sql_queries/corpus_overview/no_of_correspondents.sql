SELECT COUNT(*) AS 'Total number of correspondents of Erasmus'
FROM era_cdb_v3.correspondents
WHERE correspondents_id NOT IN ('erasmus_desiderius_viaf_95982394',
                                'unnamed_person_viaf_unknown')
