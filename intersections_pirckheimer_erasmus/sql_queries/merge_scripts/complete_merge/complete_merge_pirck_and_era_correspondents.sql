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
FROM
(SELECT *
FROM era_cdb.correspondents
UNION ALL
  (SELECT *
   FROM wpirck_cdb.correspondents AS P
   WHERE P.correspondents_id NOT IN
       (SELECT E.correspondents_id
        FROM era_cdb.correspondents AS E))) AS X
