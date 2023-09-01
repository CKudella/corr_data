SELECT DISTINCT sender_id, name_in_edition,
                COUNT(*) 'Number of letters sent to Erasmus from this correspondent'
FROM letters
WHERE recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY sender_id
ORDER BY COUNT(*) DESC
