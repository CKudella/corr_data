SELECT DISTINCT sender_id,
                COUNT(*) 'Number of letters sent to Pirckheimer from this correspondent'
FROM letters
WHERE recipient_id = 'pirckheimer_willibald_viaf_27173507'
GROUP BY sender_id
ORDER BY COUNT(*) DESC
