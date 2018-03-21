SELECT E.correspondents_id,
       E.name_in_edition
FROM wpirck_cdb_v1.correspondents AS P,
     era_cdb_v3.correspondents AS E
WHERE P.correspondents_id = E.correspondents_id
  AND P.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                  'erasmus_desiderius_viaf_95982394',
                                  'pirckheimer_willibald_viaf_27173507')
  AND E.correspondents_id NOT IN ('unnamed_person_viaf_not_applicable',
                                  'erasmus_desiderius_viaf_95982394',
                                  'pirckheimer_willibald_viaf_27173507')
