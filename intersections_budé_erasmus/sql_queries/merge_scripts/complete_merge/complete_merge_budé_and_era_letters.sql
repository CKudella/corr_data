SELECT * from era_cdb_v3.letters UNION ALL (Select * from budé_cdb_v1.letters WHERE letters_id NOT LIKE '%_cwe_%')
