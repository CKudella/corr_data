SELECT * FROM era_cdb_v3.correspondents UNION ALL (SELECT * FROM budé_cdb_v1.correspondents AS B WHERE B.correspondents_id NOT IN (SELECT E.correspondents_id FROM era_cdb_v3.correspondents AS E))
