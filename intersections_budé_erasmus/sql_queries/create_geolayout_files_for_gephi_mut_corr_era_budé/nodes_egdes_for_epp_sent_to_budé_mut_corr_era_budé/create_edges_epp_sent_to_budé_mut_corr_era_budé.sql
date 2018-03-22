SELECT source_loc_id AS 'Source',
       target_loc_id AS 'Target',
FROM budé_cdb_v1.letters
WHERE recipient_id = 'budé_guillaume_viaf_105878228'
  AND sender_id IN
    (SELECT E.correspondents_id
     FROM budé_cdb_v1.correspondents AS B,
          era_cdb_v3.correspondents AS E
     WHERE B.correspondents_id = E.correspondents_id
       AND B.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'budé_guillaume_viaf_105878228')
       AND E.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                       'erasmus_desiderius_viaf_95982394',
                                       'budé_guillaume_viaf_105878228'))
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id NOT LIKE 'unknown%'
