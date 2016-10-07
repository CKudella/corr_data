SELECT * from era_cdb_v3.letters UNION ALL (Select * from wpirck_cdb_v1.letters WHERE letters_id NOT LIKE '%_cwe_%')
