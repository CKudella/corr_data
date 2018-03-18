SELECT DISTINCT sender_id,
                COUNT(*) 'Number of letters sent to Budé from this correspondent'
FROM letters
WHERE recipient_id = 'budé_guillaume_viaf_105878228'
GROUP BY sender_id
ORDER BY COUNT(*) DESC
