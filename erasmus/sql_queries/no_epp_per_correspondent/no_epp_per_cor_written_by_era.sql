SELECT DISTINCT recipient_id,
                COUNT(*) 'Number of letters sent from Erasmus to this correspondent'
FROM letters
WHERE sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY recipient_id
ORDER BY COUNT(*) DESC
