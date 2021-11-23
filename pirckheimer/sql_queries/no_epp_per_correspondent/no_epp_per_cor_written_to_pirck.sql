SELECT DISTINCT sender_id,
                COUNT(*) 'Number of letters sent to Pirckheimer from this correspondent'
FROM letters
WHERE recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY sender_id
ORDER BY COUNT(*) DESC
