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
FROM era_cdb.correspondents AS X
WHERE X.correspondents_id IN
    (SELECT P.correspondents_id
     FROM wpirck_cdb.correspondents AS P,
          era_cdb.correspondents AS E
     WHERE P.correspondents_id = E.correspondents_id
       AND P.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f'
       AND E.correspondents_id NOT LIKE 'be1dcbc4-3987-472a-b4a0-c3305ead139f')
