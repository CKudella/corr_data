SELECT COUNT(*) AS 'Total number of correspondents of Budé'
FROM correspondents
WHERE correspondents_id NOT IN ('budé_guillaume_viaf_105878228',
                                'unnamed_person_viaf_unknown')
