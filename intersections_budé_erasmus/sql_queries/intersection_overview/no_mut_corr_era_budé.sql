SELECT COUNT(*) AS 'Number of mutual correspondents of Budé and Erasmus'
FROM budé_cdb_v1.correspondents AS B,
     era_cdb_v3.correspondents AS E
WHERE B.correspondents_id = E.correspondents_id
  AND B.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                  'erasmus_desiderius_viaf_95982394',
                                  'budé_guillaume_viaf_105878228')
  AND E.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                  'erasmus_desiderius_viaf_95982394',
                                  'budé_guillaume_viaf_105878228')
