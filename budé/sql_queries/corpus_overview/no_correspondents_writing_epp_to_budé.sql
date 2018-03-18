SELECT COUNT(DISTINCT sender_id) AS 'Total number of correspondents who have written letters to Budé'
FROM budé_cdb_v1.letters
WHERE recipient_id = 'budé_guillaume_viaf_105878228'
