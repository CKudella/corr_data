SELECT COUNT(correspondents_id) AS 'Total number for correspondents in the dataset'
 FROM budé_cdb_v1.correspondents
 WHERE correspondents_id NOT IN ('budé_guillaume_viaf_105878228',
                                 'unnamed_person_viaf_not_applicable')
