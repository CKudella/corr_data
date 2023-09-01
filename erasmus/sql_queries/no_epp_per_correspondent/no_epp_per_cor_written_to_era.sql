SELECT DISTINCT L.sender_id, C.name_in_edition,
                COUNT(*) AS 'Number of letters sent to Erasmus from this correspondent'
FROM letters AS L
JOIN correspondents AS C ON L.sender_id = C.correspondents_id
WHERE L.recipient_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY L.sender_id, C.name_in_edition
ORDER BY COUNT(*) DESC;
