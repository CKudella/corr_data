SELECT DISTINCT L.recipient_id, C.name_in_edition,
                COUNT(*) AS 'Number of letters sent by Erasmus to this correspondent'
FROM era_cdb_v3.letters AS L
JOIN correspondents AS C ON L.recipient_id = C.correspondents_id
WHERE L.sender_id = '17c580aa-3ba7-4851-8f26-9b3a0ebeadbf'
GROUP BY L.recipient_id, C.name_in_edition
ORDER BY COUNT(*) DESC;
