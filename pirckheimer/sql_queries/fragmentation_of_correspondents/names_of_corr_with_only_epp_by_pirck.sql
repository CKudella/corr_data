SELECT name_in_edition
FROM correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters)
GROUP BY name_in_edition
