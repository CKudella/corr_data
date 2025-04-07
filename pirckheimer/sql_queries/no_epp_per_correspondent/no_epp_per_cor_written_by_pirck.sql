SELECT DISTINCT L.recipient_id, C.name_in_edition,
                COUNT(*) AS 'Number of letters sent by Pirckheimer to this correspondent'
FROM wpirck_cdb.letters AS L
JOIN correspondents AS C ON L.recipient_id = C.correspondents_id
WHERE L.sender_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY L.recipient_id, C.name_in_edition
ORDER BY COUNT(*) DESC;
