SELECT DISTINCT recipient_id,
                COUNT(*) 'Number of letters sent from Pirckheimer to this correspondent'
FROM letters
WHERE sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY recipient_id
ORDER BY COUNT(*) DESC
