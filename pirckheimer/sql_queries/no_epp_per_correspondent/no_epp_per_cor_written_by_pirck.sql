SELECT DISTINCT recipient_id,
                COUNT(*) 'Number of letters sent by Pirckheimer'
FROM letters
WHERE sender_id = 'pirckheimer_willibald_viaf_27173507'
GROUP BY recipient_id
ORDER BY COUNT(*) DESC
