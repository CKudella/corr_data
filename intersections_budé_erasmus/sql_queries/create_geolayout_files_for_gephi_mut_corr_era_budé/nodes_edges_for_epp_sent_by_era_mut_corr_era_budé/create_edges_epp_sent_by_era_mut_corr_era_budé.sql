SELECT source_loc_id AS 'Source',
       target_loc_id AS 'Target',
FROM era_cdb_v3.letters
WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
  AND recipient_id IN
    (SELECT X.correspondents_id
     FROM budé_cdb_v1.correspondents AS X
     WHERE X.correspondents_id IN
         (SELECT E.correspondents_id
          FROM era_cdb_v3.correspondents AS E,
               budé_cdb_v1.correspondents AS B
          WHERE E.correspondents_id = B.correspondents_id
            AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
            AND B.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'))
  AND source_loc_id NOT LIKE 'unknown%'
  AND target_loc_id NOT LIKE 'unknown%'
