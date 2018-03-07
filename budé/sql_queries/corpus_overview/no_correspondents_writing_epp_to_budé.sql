SELECT COUNT(DISTINCT sender_id) AS 'Total number of correspondents who have written letters to Budé'
FROM letters
WHERE recipient_id = 'budé_guillaume_viaf_105878228'
