SELECT DISTINCT sender_id,
                COUNT(*) 'Number of letters sent to Erasmus from this correspondent'
FROM letters
WHERE recipient_id = 'erasmus_desiderius_viaf_95982394'
GROUP BY sender_id
ORDER BY COUNT(*) DESC
