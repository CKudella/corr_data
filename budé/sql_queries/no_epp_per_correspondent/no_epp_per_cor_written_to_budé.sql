SELECT DISTINCT sender_id,
                COUNT(*) 'Number of letters sent to Budé from this correspondent'
FROM letters
WHERE recipient_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
GROUP BY sender_id
ORDER BY COUNT(*) DESC
