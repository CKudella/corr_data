SELECT COUNT(correspondents_id) AS 'Total number of correspondents (type: individual) in the dataset'
FROM budé_cdb_v1.correspondents
WHERE correspondents_id NOT IN ('budé_guillaume_viaf_105878228',
                                'unnamed_person_viaf_not_applicable')
  AND correspondents.type = 'individual'
