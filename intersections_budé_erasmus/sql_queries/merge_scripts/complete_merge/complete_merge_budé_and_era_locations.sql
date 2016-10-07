SELECT * FROM era_cdb_v3.locations UNION ALL (SELECT * FROM budé_cdb_v1.locations AS B WHERE B.locations_id NOT IN (SELECT E.locations_id FROM era_cdb_v3.locations AS E))
