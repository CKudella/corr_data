SELECT DISTINCT recipient_id,
                COUNT(*) 'Number of letters sent from Budé to this correspondent'
FROM letters
WHERE sender_id = 'budé_guillaume_viaf_105878228'
GROUP BY recipient_id
ORDER BY COUNT(*) DESC
