SELECT DISTINCT L.recipient_id, C.name_in_edition,
                COUNT(*) AS 'Number of letters sent from Budé to this correspondent'
FROM letters AS L
JOIN correspondents AS C ON L.recipient_id = C.correspondents_id
WHERE L.sender_id = 'c0b89c75-45b8-4b04-bfd7-25bfe9ed040b'
GROUP BY L.recipient_id, C.name_in_edition
ORDER BY COUNT(*) DESC;
