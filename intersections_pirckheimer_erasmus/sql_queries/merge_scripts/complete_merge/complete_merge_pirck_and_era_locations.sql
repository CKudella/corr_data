SELECT * FROM era_cdb_v3.locations UNION ALL (SELECT * FROM wpirck_cdb_v1.locations AS P WHERE P.locations_id NOT IN (SELECT E.locations_id FROM era_cdb_v3.locations AS E))
