SELECT DISTINCT recipient_id,
                COUNT(*) 'Number of letters sent from Budé to this correspondent'
FROM letters
WHERE sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
GROUP BY recipient_id
ORDER BY COUNT(*) DESC
