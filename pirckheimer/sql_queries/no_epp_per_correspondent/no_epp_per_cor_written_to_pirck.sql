SELECT DISTINCT L.sender_id, C.name_in_edition,
                COUNT(*) AS 'Number of letters sent to Pirckheimer from this correspondent'
FROM wpirck_cdb.letters AS L
JOIN correspondents AS C ON L.sender_id = C.correspondents_id
WHERE L.recipient_id = 'd9233b24-a98c-4279-8065-e2ab70c0d080'
GROUP BY L.sender_id, C.name_in_edition
ORDER BY COUNT(*) DESC;
