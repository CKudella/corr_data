SELECT X.correspondents_id AS 'Id',
       X.type,
       X.gender,
       X.name_in_edition AS 'Label',
       X.pob_loc_id,
       X.pob_loc_annotation,
       X.dob_year1,
       X.dob_computable1,
       X.dob_has_range,
       X.dob_year2,
       X.dob_computable2,
       X.pod_loc_id,
       X.pod_loc_annotation,
       X.dod_year1,
       X.dod_computable1,
       X.dod_has_range,
       X.dod_year2
FROM era_cdb_v3.correspondents AS X
WHERE X.correspondents_id IN
    (SELECT B.correspondents_id
     FROM budé_cdb_v1.correspondents AS B,
          era_cdb_v3.correspondents AS E
     WHERE B.correspondents_id = E.correspondents_id
       AND B.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable'
       AND E.correspondents_id NOT LIKE 'unnamed_person_viaf_not_applicable')
