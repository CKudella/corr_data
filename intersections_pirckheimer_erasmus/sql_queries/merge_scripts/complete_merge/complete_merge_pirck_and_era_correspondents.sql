SELECT * FROM era_cdb_v3.correspondents UNION ALL (SELECT * FROM wpirck_cdb_v1.correspondents AS P WHERE P.correspondents_id NOT IN (SELECT E.correspondents_id FROM era_cdb_v3.correspondents AS E))
