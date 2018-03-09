SELECT COUNT(correspondents_id) AS 'Total number for correspondents in the dataset'
 FROM wpirck_cdb_v1.correspondents
 WHERE correspondents_id NOT IN ('pirckheimer_willibald_viaf_27173507',
                                 'unnamed_person_viaf_not_applicable')
