SELECT DISTINCT recipient_id,
                COUNT(*) 'Number of letters sent from Erasmus to this correspondent'
FROM letters
WHERE sender_id = 'erasmus_desiderius_viaf_95982394'
GROUP BY recipient_id
ORDER BY COUNT(*) DESC
