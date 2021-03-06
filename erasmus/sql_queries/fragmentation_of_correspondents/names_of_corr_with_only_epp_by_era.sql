SELECT name_in_edition AS 'Names of correspondents who received letters from Erasmus but did not write to him'
FROM correspondents
WHERE correspondents.correspondents_id NOT IN
    (SELECT DISTINCT sender_id
     FROM letters)
GROUP BY name_in_edition
