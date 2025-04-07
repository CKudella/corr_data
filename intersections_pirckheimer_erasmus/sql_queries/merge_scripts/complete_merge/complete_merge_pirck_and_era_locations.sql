SELECT LOC.locations_id AS 'Id',
       LOC.locations_name_modern AS 'Label',
       LOC.locations_modern_state,
       LOC.locations_modern_province,
       LOC.locations_lat AS 'Latitude',
       LOC.locations_lng AS 'Longitude',
       LOC.locations_ll_combined
FROM
  (SELECT *
   FROM era_cdb.locations
   UNION ALL
     (SELECT *
      FROM wpirck_cdb.locations AS P
      WHERE P.locations_id NOT IN
          (SELECT E.locations_id
           FROM era_cdb.locations AS E))) AS LOC
