SELECT LOC.locations_id AS 'Id',
       LOC.locations_name_modern AS 'Label',
       LOC.locations_modern_state,
       LOC.locations_modern_province,
       LOC.locations_lat AS 'Latitude',
       LOC.locations_lng AS 'Longitude',
       LOC.locations_ll_combined
FROM
  (SELECT *
   FROM era_cdb_v3.locations
   UNION ALL
     (SELECT *
      FROM budé_cdb_v1.locations AS B
      WHERE B.locations_id NOT IN
          (SELECT E.locations_id
           FROM era_cdb_v3.locations AS E))) AS LOC
