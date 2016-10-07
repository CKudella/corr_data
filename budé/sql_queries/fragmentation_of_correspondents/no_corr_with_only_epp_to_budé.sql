SELECT COUNT(*) AS 'Number of Correspondents that only wrote letters to Budé' FROM budé_cdb_v1.correspondents WHERE correspondents.correspondents_id NOT IN (SELECT DISTINCT recipient_id FROM letters)
